// Everything the site knows about the repository, gathered once at build time from three sources: the facts Nix
// evaluates, the docstrings in the module files, and git history.

import { execFileSync } from "node:child_process";
import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import { join, relative, resolve } from "node:path";
import { marked } from "marked";

export const github = "https://github.com/mariovagomarzal/dotfiles";

// Astro runs from docs/, one level below the repository.
const root = resolve(process.cwd(), "..");
const modulesDir = join(root, "nix/modules");

function run(command: string, args: string[]): string {
  return execFileSync(command, args, { cwd: root, encoding: "utf8", maxBuffer: 64 * 1024 * 1024 });
}

// --- Evaluated facts --------------------------------------------------------------------------------------------

export interface Facts {
  packages?: string[];
  programs?: string[];
  services?: string[];
  fonts?: string[];
  brews?: string[];
  casks?: string[];
  apps?: string[];
}

export interface Host {
  name: string;
  /** What manages the machine: "nix-darwin", "NixOS" or "home-manager" alone. */
  manager: string;
  /** The machine's system, or null for one managed by home-manager alone, which can be any. */
  platform: string | null;
  modules: string[];
  users: { name: string; modules: string[] }[];
}

const switchCommands: Record<string, (host: Host) => string[]> = {
  "nix-darwin": (h) => [`sudo darwin-rebuild switch --flake .#${h.name}`],
  NixOS: (h) => [`sudo nixos-rebuild switch --flake .#${h.name}`],
  "home-manager": (h) => h.users.map((u) => `home-manager switch --flake .#${u.name}@${h.name}`),
};

/** The commands that apply a host's configuration, run from the repository root. */
export const switchCommandsOf = (host: Host): string[] => switchCommands[host.manager]?.(host) ?? [];

interface Data {
  hosts: Host[];
  modules: Record<string, Facts>;
}

// The runner, `nix run .#dotfiles-docs`, evaluates the configurations and points here to the result.
function loadData(): Data {
  const file = process.env.DOCS_DATA;
  if (!file) throw new Error("DOCS_DATA is not set; build the site with `nix run .#dotfiles-docs`.");
  return JSON.parse(readFileSync(file, "utf8"));
}

const data = loadData();
export const hosts = data.hosts;

// --- Docstrings -------------------------------------------------------------------------------------------------

export interface Doc {
  summary?: string;
  html?: string;
  /** Everything after the summary, for pages that already show it. */
  rest?: string;
}

// The RFC 145 doc comment opening the file, if any, with its common indentation removed.
function docstring(file: string): Doc {
  const match = readFileSync(file, "utf8").match(/^\s*\/\*\*([\s\S]*?)\*\//);
  if (!match) return {};
  const lines = match[1].split("\n");
  const indent = Math.min(...lines.filter((l) => l.trim()).map((l) => l.match(/^ */)![0].length));
  const text = lines
    .map((l) => l.slice(indent))
    .join("\n")
    .trim();
  const [first, ...more] = text.split(/\n\s*\n/);
  return {
    summary: first.replace(/\s+/g, " "),
    html: marked.parse(text, { async: false }),
    rest: more.length ? marked.parse(more.join("\n\n"), { async: false }) : undefined,
  };
}

// --- History ----------------------------------------------------------------------------------------------------

export interface Commit {
  hash: string;
  date: string;
  time: number;
  type?: string;
  scope?: string;
  breaking: boolean;
  description: string;
  body: string;
}

const SEP = "\x1f";
const END = "\x1e";
const FORMAT = ["%H", "%as", "%at", "%s", "%b"].join("%x1f") + "%x1e";

function parse(raw: string): Commit[] {
  return raw
    .split(END)
    .map((r) => r.trim())
    .filter(Boolean)
    .map((r) => {
      const [hash, date, time, subject, body] = r.split(SEP);
      const m = subject.match(/^(\w+)(?:\(([^)]+)\))?(!)?: (.*)$/);
      return {
        hash,
        date,
        time: Number(time),
        type: m?.[1],
        scope: m?.[2],
        breaking: Boolean(m?.[3]),
        description: m?.[4] ?? subject,
        body: (body ?? "").trim(),
      };
    });
}

// Following each file across renames keeps the history from before modules were indexed by feature.
function historyOf(files: string[]): Commit[] {
  const seen = new Map<string, Commit>();
  for (const file of files) {
    for (const c of parse(run("git", ["log", "--follow", `--format=${FORMAT}`, "--", relative(root, file)]))) {
      seen.set(c.hash, c);
    }
  }
  return [...seen.values()].sort((a, b) => b.time - a.time);
}

// --- Modules ----------------------------------------------------------------------------------------------------

export interface ModuleClass {
  name: string;
  source: string;
  doc: Doc;
  facts: Facts;
  importedBy: string[];
}

export interface Module {
  name: string;
  classes: ModuleClass[];
  summary?: string;
  history: Commit[];
}

function filesIn(path: string): string[] {
  if (!statSync(path).isDirectory()) return [path];
  return readdirSync(path)
    .filter((e) => !e.startsWith("."))
    .flatMap((e) => filesIn(join(path, e)));
}

// Who imports a module's class, as "host" for a system and "user@host" for a home.
function importers(id: string): string[] {
  return hosts.flatMap((h) => [
    ...(h.modules.includes(id) ? [h.name] : []),
    ...h.users.filter((u) => u.modules.includes(id)).map((u) => `${u.name}@${h.name}`),
  ]);
}

// Base classes first, so a module's summary comes from what every host can import.
const classOrder = ["home", "nixos", "darwin", "home-linux", "home-darwin"];
const rank = (cls: string) => {
  const i = classOrder.indexOf(cls);
  return i === -1 ? classOrder.length : i;
};

export const modules: Module[] = readdirSync(modulesDir)
  .filter((e) => !e.startsWith("."))
  .sort()
  .map((name) => {
    const dir = join(modulesDir, name);
    const entries = readdirSync(dir)
      .filter((e) => !e.startsWith("."))
      .sort();
    const classes = entries.map((entry) => {
      const path = join(dir, entry);
      const isDir = statSync(path).isDirectory();
      const cls = entry.replace(/\.nix$/, "");
      const main = isDir ? join(path, "default.nix") : path;
      const id = `${name}/${cls}`;
      return {
        name: cls,
        source: relative(root, existsSync(main) ? main : path),
        doc: existsSync(main) ? docstring(main) : {},
        facts: data.modules[id] ?? {},
        importedBy: importers(id),
      };
    });
    classes.sort((a, b) => rank(a.name) - rank(b.name));
    return {
      name,
      classes,
      summary: classes.find((c) => c.doc.summary)?.doc.summary,
      history: historyOf(filesIn(dir)),
    };
  });

export const moduleNames = new Set(modules.map((m) => m.name));

export const hostHistory = (name: string) => historyOf(filesIn(join(root, "nix/hosts", name)));

// --- Changelog --------------------------------------------------------------------------------------------------

export interface Release {
  /** The pull request's title, kept in the body of its merge commit; absent for unmerged or direct work. */
  title?: string;
  pr?: number;
  branch?: string;
  date?: string;
  hash?: string;
  tags: string[];
  commits: Commit[];
}

// Commits that only maintained the old generated changelog say nothing about the machines.
const noise = (c: Commit) => c.description === "update the changelog";

const log = (...args: string[]) => parse(run("git", ["log", `--format=${FORMAT}`, ...args])).filter((c) => !noise(c));

// Tags by the commit they point at, so old date tags can label the release that contains them.
function tagsByCommit(): Map<string, string[]> {
  // An annotated tag points at a tag object; `*objectname` is the commit behind it.
  const format = "%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end)%00%(refname:short)";
  const map = new Map<string, string[]>();
  for (const line of run("git", ["for-each-ref", "refs/tags", `--format=${format}`]).trim().split("\n")) {
    if (!line) continue;
    const [hash, tag] = line.split("\0");
    map.set(hash, [...(map.get(hash) ?? []), tag]);
  }
  return map;
}

// One merged pull request into main is one release. Work on the current branch that main lacks comes first, and
// commits made straight on main are gathered between the merges around them.
// A checkout made for CI may have no local `main`, only the remote's.
function mainRef(): string {
  for (const ref of ["main", "origin/main"]) {
    try {
      run("git", ["rev-parse", "--verify", "--quiet", ref]);
      return ref;
    } catch {}
  }
  throw new Error("No `main` or `origin/main` to read releases from.");
}

// Merge commits come in two shapes: GitHub's default, and the hand-edited one used before it.
function parseMerge(subject: string): { pr?: number; branch?: string } {
  const github = subject.match(/^Merge pull request #(\d+) from [^/]+\/(.+)$/);
  if (github) return { pr: Number(github[1]), branch: github[2] };
  return { branch: subject.match(/^Merge `([^`]+)`/)?.[1] };
}

export function releases(): Release[] {
  const tags = tagsByCommit();
  const out: Release[] = [];
  const main = mainRef();

  const pending = log("--no-merges", `${main}..HEAD`);
  if (pending.length) out.push({ tags: [], commits: pending });

  let direct: Commit[] = [];
  const flush = () => {
    if (!direct.length) return;
    out.push({ date: direct[0].date, tags: direct.flatMap((c) => tags.get(c.hash) ?? []), commits: direct });
    direct = [];
  };

  for (const line of run("git", ["log", "--first-parent", "--format=%H%x1f%P%x1f%as", main]).trim().split("\n")) {
    const [hash, parents, date] = line.split(SEP);
    const [first, second] = parents.split(" ");
    if (!second) {
      direct.push(...log("-1", hash));
      continue;
    }
    flush();
    const [subject, ...body] = run("git", ["log", "-1", "--format=%s%n%b", hash]).trim().split("\n");
    const commits = log("--no-merges", `${first}..${second}`);
    out.push({
      title: body.join(" ").trim().replace(/\.$/, "") || subject,
      ...parseMerge(subject),
      date,
      hash,
      tags: [hash, ...commits.map((c) => c.hash)].flatMap((h) => tags.get(h) ?? []),
      commits,
    });
  }
  flush();
  return out;
}

// The headings a release's commits fall under, in the order a reader looks for them.
export const kinds: { type: string; label: string }[] = [
  { type: "feat", label: "features" },
  { type: "fix", label: "fixes" },
  { type: "refactor", label: "refactors" },
  { type: "docs", label: "docs" },
  { type: "build", label: "build" },
  { type: "style", label: "style" },
  { type: "chore", label: "chores" },
];

export const commitUrl = (hash: string) => `${github}/commit/${hash}`;
export const pullUrl = (pr: number) => `${github}/pull/${pr}`;
export const sourceUrl = (path: string) => `${github}/blob/main/${path}`;
