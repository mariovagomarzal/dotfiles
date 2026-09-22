# /commit

Create one or more git commits for the current changes, adapting to the
commit style already established in the repository.

**Argument:** $ARGUMENTS

The argument is optional and may refer to one or more of the following:
- Specific file paths to commit (e.g., `src/foo.py src/bar.py`)
- A description of the changes to commit (e.g., "the refactoring of the parser")

If no argument is provided, consider all uncommitted changes.

---

## Workflow

1. **Learn the commit style** — run `git log --oneline -20` (or more if needed)
   to study the existing commit messages. Pay attention to:
   - Format: conventional commits (`type(scope): message`), imperative mood,
     sentence case, etc.
   - Length and detail level of the subject line and body.
   - Whether scopes, footers, or issue references are used.
   - Adopt the same style exactly for any new commits.

2. **Identify the changes in scope** — based on the argument:
   - If specific **files** are mentioned, focus on those files only.
   - If a **description** is given, identify which changed files relate to it.
   - If **no argument** is provided, consider all staged and unstaged changes
     plus untracked files.
   Run `git status` (never with `-uall`) and `git diff` / `git diff --cached`
   as needed.

3. **Understand what changed** — read the relevant diffs and, when the diff
   alone is not enough to understand the intent, read the surrounding code.
   Determine the *purpose* of each change (bug fix, new feature, refactor,
   docs, chore, etc.).

4. **Decide on one or multiple commits:**
   - **Default to a single commit** unless the changes clearly mix unrelated
     concerns (e.g., a bug fix and an unrelated new feature).
   - If multiple commits would genuinely help, **propose them** to the user
     with a summary of what each commit would contain and its draft message,
     then **wait for confirmation** before proceeding.

5. **Create the commit(s):**
   - Stage only the relevant files by name — never use `git add -A` or
     `git add .`.
   - Write the commit message in the style learned in step 1. Focus on *why*
     the change was made, not just *what* changed.
   - Always pass the message via a HEREDOC:
     ```
     git commit -m "$(cat <<'EOF'
     commit message here
     EOF
     )"
     ```
   - Run `git status` after committing to verify success.

---

## What NOT to do

- Do not push to the remote.
- Do not amend existing commits.
- Do not use `git add -A` or `git add .`.
- Do not skip hooks (`--no-verify`).
- Do not commit files that likely contain secrets (`.env`, credentials, keys).
  Warn the user if such files are in scope.
- Do not create empty commits.
- Do not invent a commit style — always match the repository's existing style.
