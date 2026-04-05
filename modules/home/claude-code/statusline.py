#!/usr/bin/env python3
"""
Claude Code status line script.

Reads JSON from stdin (as provided by Claude Code's statusLine hook) and
prints a formatted status line to stdout.

The status line contains the following segments:
  1. Model         - Display name (or ID) of the active model.
  2. Project       - Basename of the current working directory.
  3. Git           - Current branch (or short SHA if detached) with a
                     dirty/clean indicator dot.
  4. Context       - Context window usage as a progress bar and percentage.
  5. 5-hour limit  - Five-hour rate limit usage as a progress bar and
                     percentage.
  6. Weekly limit  - Seven-day rate limit usage as a progress bar and
                     percentage.
"""

import json
import os
import subprocess
import sys
from dataclasses import dataclass

# ANSI helpers.

RESET: str = "\x1b[0m"
COLORS: dict[str, int] = {
    "grey": 245,
    "dark_green": 22,
    "olive": 64,
    "dark_orange": 136,
    "bright_orange": 166,
    "dark_red": 88,
    "green": 82,
    "orange": 214,
    "red": 196,
    "cornflower_blue": 75,
    "cyan": 51,
    "gold": 220,
    "purple": 141,
    "salmon": 203,
}


def color_fg(text: str, color: str) -> str:
    """Wrap `text` in a 256-color ANSI foreground escape."""
    color_code: int = COLORS.get(color, COLORS["grey"])
    return f"\x1b[38;5;{color_code}m{text}{RESET}"


# Percentage color mapping and progress bar helpers.


@dataclass
class PctColorMap:
    """Maps percentage intervals to color names.

    `intervals` is a list of `(upper_bound, color_name)` tuples, evaluated in
    order.  The first interval whose upper bound is >= the given percentage
    wins.  A fallback color is returned for ``None`` or out-of-range values.
    """

    intervals: list[tuple[float, str]]
    fallback: str = "grey"

    def __call__(self, pct: float | None) -> str:
        if pct is None:
            return self.fallback
        for upper, color in self.intervals:
            if pct <= upper:
                return color
        return self.fallback


@dataclass
class ProgressBar:
    """Renders a colored progress bar with an adjacent percentage number."""

    width: int
    color_map: PctColorMap
    fill_char: str = "▓"
    empty_char: str = "░"
    before: str = "["
    after: str = "]"
    spacing: str = ""

    def display_bar(self, pct: float | None) -> str:
        """Return the bar portion (brackets + fill + empty)."""
        if pct is None:
            filled = 0
        else:
            filled = round(max(0.0, min(100.0, pct)) / 100 * self.width)
        empty = self.width - filled

        color = self.color_map(pct)
        filled_body = color_fg(
            self.spacing.join(self.fill_char * filled), color
        )
        empty_body = color_fg(
            self.spacing.join(self.empty_char * empty), "grey"
        )

        sep = self.spacing if filled and empty else ""
        return f"{self.before}{filled_body}{sep}{empty_body}{self.after}"

    def display_number(self, pct: float | None) -> str:
        """Return the percentage as a colored string."""
        if pct is None:
            return color_fg("—", self.color_map.fallback)
        color = self.color_map(pct)
        return color_fg(f"{pct:.0f}%", color)

    def __call__(self, pct: float | None) -> str:
        return f"{self.display_bar(pct)} {self.display_number(pct)}"


# Git helpers.

def git_info(cwd: str) -> tuple[str | None, bool]:
    """
    Return `(branch_name, is_dirty)` for the repository at `cwd`.
    Returns `(None, False)` when `cwd` is not inside a git repository or git
    is not available.
    """
    env = os.environ.copy()
    env["GIT_OPTIONAL_LOCKS"] = "0"

    def run(args: list[str]) -> subprocess.CompletedProcess:
        return subprocess.run(
            args,
            cwd=cwd,
            capture_output=True,
            text=True,
            env=env,
        )

    try:
        # Branch name.
        result = run(["git", "rev-parse", "--abbrev-ref", "HEAD"])
        if result.returncode != 0:
            return None, False
        branch = result.stdout.strip()
        if branch == "HEAD":
            # Detached HEAD – use short SHA instead.
            sha_result = run(["git", "rev-parse", "--short", "HEAD"])
            branch = sha_result.stdout.strip() if sha_result.returncode == 0 else "HEAD"

        # Dirty check (staged + unstaged changes; ignores untracked files).
        status_result = run(["git", "status", "--porcelain"])
        is_dirty = bool(status_result.returncode == 0 and status_result.stdout.strip())

        return branch, is_dirty
    except FileNotFoundError:
        # Git not found on PATH.
        return None, False


# Segment builders.

SEGMENT_SEPARATOR = "  │  "


@dataclass
class Segment:
    """Base class for status line segments."""

    icon: str
    color: str

    def parse_data(self, data: dict) -> str:
        raise NotImplementedError

    def display(self, data: dict) -> str:
        body = self.parse_data(data)
        if body is None:
            return ""
        return f"{color_fg(self.icon, self.color)}  {body}"


class ModelSegment(Segment):
    def parse_data(self, data: dict) -> str:
        return (
            data.get("model", {}).get("display_name")
            or data.get("model", {}).get("id")
            or "unknown"
        )


class ProjectSegment(Segment):
    def parse_data(self, data: dict) -> str:
        cwd = (
            data.get("workspace", {}).get("current_dir")
            or data.get("cwd")
            or os.getcwd()
        )
        return os.path.basename(cwd.rstrip("/")) or cwd


class GitSegment(Segment):
    def parse_data(self, data: dict) -> str | None:
        cwd = (
            data.get("workspace", {}).get("current_dir")
            or data.get("cwd")
            or os.getcwd()
        )
        branch, is_dirty = git_info(cwd)
        if branch is None:
            return None
        dirty_marker = f" {color_fg('●', 'orange')}" if is_dirty else f" {color_fg('●', 'green')}"
        return f"{branch}{dirty_marker}"


DEFAULT_PCT_COLOR_MAP = PctColorMap(
    intervals=[
        (20, "dark_green"),
        (40, "olive"),
        (60, "dark_orange"),
        (80, "bright_orange"),
        (100, "dark_red"),
    ],
)

DEFAULT_PROGRESS_BAR = ProgressBar(width=10, color_map=DEFAULT_PCT_COLOR_MAP)

CONTEXT_PROGRESS_BAR = ProgressBar(
    width=5,
    color_map=DEFAULT_PCT_COLOR_MAP,
    fill_char="●",
    empty_char="·",
    before="",
    after="",
    spacing=" ",
)

WEEKLY_PROGRESS_BAR = ProgressBar(width=5, color_map=DEFAULT_PCT_COLOR_MAP)


class ContextSegment(Segment):
    def parse_data(self, data: dict) -> str:
        pct = data.get("context_window", {}).get("used_percentage")
        return CONTEXT_PROGRESS_BAR(pct)


class FiveHourRateLimitSegment(Segment):
    def parse_data(self, data: dict) -> str | None:
        pct = data.get("rate_limits", {}).get("five_hour", {}).get("used_percentage")
        if pct is None:
            return None
        return DEFAULT_PROGRESS_BAR(pct)


class WeeklyRateLimitSegment(Segment):
    def parse_data(self, data: dict) -> str | None:
        pct = data.get("rate_limits", {}).get("seven_day", {}).get("used_percentage")
        if pct is None:
            return None
        return WEEKLY_PROGRESS_BAR(pct)


# Main entry point.

def main() -> None:
    try:
        raw = sys.stdin.read()
        data: dict = json.loads(raw) if raw.strip() else {}
    except (json.JSONDecodeError, OSError):
        data = {}

    segments = [
        ModelSegment("󰧑", "purple"),
        ProjectSegment("󰉋", "cornflower_blue"),
        GitSegment("󰊢", "orange"),
        ContextSegment("󰡵", "cyan"),
        FiveHourRateLimitSegment("󰅒", "gold"),
        WeeklyRateLimitSegment("󰃭", "salmon"),
    ]

    line = SEGMENT_SEPARATOR.join(
        seg for s in segments if (seg := s.display(data))
    )

    print(line)


if __name__ == "__main__":
    main()
