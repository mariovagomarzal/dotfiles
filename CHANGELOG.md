# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [CalVer](https://calver.org/), with the `YYYY.0M.0D`
format.

## [Unreleased]

### Added

- Development dependencies managed with Nix (via flakes). In particular:
  - Development shell with [devshell](https://github.com/numtide/devshell).
  - A `Justfile` with recipes to setup and manage the development environment.
  - `pre-commit` hooks with
    [pre-commit-hooks.nix](https://github.com/cachix/pre-commit-hooks.nix/tree/master)
  - Documentation in the README file related to Nix dependencies.

### Removed

- Support for `dotbot` tool. In particular:
  - `dotbot` and `dotbot-brew` submodules.
  - `install` script and `install.conf.yaml` file.
  - Dotfiles that were managed by `dotbot`.
  - Documentation in the README file related to `dotbot`.
- Development dependecies managed with Python. In particular:
  - Python entries in `.gitignore` file.
  - `invoke` related files.
  - `pre-commit` related files.
  - Documentation in the README file related to Python dependencies.

## [2024.03.19]

### Added

- Initial version of the dotfiles repository using the
  [dotbot](https://github.com/anishathalye/dotbot) tool.

<!-- External links -->
[unreleased]:
  https://github.com/mariovagomarzal/dotfiles/compare/2024.03.19...HEAD
[2024.03.19]:
    https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.03.19
