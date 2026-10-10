---
title: Commits
description: Commit messages, releases, and how history reaches this site.
order: 2
---

## Messages

Commits follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), enforced by a convco `commit-msg`
hook.

- **The scope is the module's name**: `feat(git): …`, `fix(firefox): …`. Changes outside modules use `config` for the
  flake and its wiring, `checks` for formatting and hooks, `docs` for this site, and the host's name for a host file.
- **The body explains why**, briefly. The diff already shows what changed; a few lines of motivation are enough, and
  short messages are easier to read later. The same goes for pull request descriptions.

## Releases

A release is a pull request merged into `main`.

- **CI checks every pull request:** it evaluates the flake and checks formatting, without building the machines. It runs
  on Linux, and on macOS only what needs it, such as evaluating nix-darwin hosts. The documentation site is built on
  Linux too.
- **Merging is always done by a person**, with GitHub's default merge commit. Nothing merges on its own.
- **CI publishes this site** when `main` changes, and each machine applies the release when its owner runs the apply
  command from the [overview](/spec/overview#commands).

## History on the site

The documentation site builds both of these from git:

- **Module history** lists the commits that changed a module's files, including those made before the files were moved.
- **The changelog** groups commits by pull request: each merge into `main` is a release, listed under the pull request's
  title, which GitHub's merge commit carries in its body. A scope that names a module links to its page.
