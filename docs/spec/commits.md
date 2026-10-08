---
title: Commits
description: Commit message conventions, releases, and how the changelog is generated.
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

## Releases

A release is a pull request merged into `main`.

- **CI checks every pull request:** it evaluates the flake and checks formatting, but does not build the systems, which
  are built on the machines themselves before a change is proposed.
- **Merging is always done by a person**, with GitHub's default merge commit. Nothing merges on its own.
- **CI publishes this site** when `main` changes.
- **Each machine applies the release** with `sudo darwin-rebuild switch --flake .`.

## History on the site

The documentation site builds both of these from git:

- **Module history** lists the commits that changed a module's files, including those made before the files were
  moved.
- **The changelog** groups commits by pull request: each merge into `main` is a release, listed under the pull
  request's title, which GitHub's merge commit carries in its body. A scope that names a module links to its page.
