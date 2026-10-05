---
title: Commits
description: Commit message conventions and how the changelog is generated.
order: 2
---

## Messages

Commits follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), enforced by a convco
`commit-msg` hook.

- **The scope is the module's name**: `feat(zed): …`, `fix(homebrew): …`. Changes outside modules use `config` for the
  flake and its wiring, `checks` for formatting and hooks, `docs` for this site, and the host's name for a host file.
- **The body explains why the change was made.** The documentation site shows it next to each commit.
- **Refactors state how they were verified**, for example that the system derivation is unchanged or that the closure
  diff is empty.

## History on the site

The documentation site builds both of these from git:

- **Module history** lists the commits that changed a module's files, including those made before the files were
  moved.
- **The changelog** groups commits by pull request: each merge into `main` is a release, listed under the pull
  request's title. A scope that names a module links to its page.
