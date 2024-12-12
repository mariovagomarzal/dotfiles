# Changelog

All notable changes to this project will be documented in this file.

Each stable version of the dotfiles repository is tagged with a date in the
format `YYYY.MM.DD`, with optional patch versions separated by a dot if more
than one version is released in the same day.

Changes for each version are grouped into the following (possibly empty)
sections:

- _Codebase_: for general changes related to the dotfiles structure or
  functionality.
- _\<Host/User Name\>_: for changes in the dotfiles of a specific host or user.
- _Development_: for changes in the development environment, such as
  dependencies or tools.
- _Documentation_: for changes in documentation-related files such as
  `README.md` or `CHANGELOG.md`.
- _Miscellaneous_: for changes that do not fit in any of the previous sections.

## [Unreleased]

### Documentation

- Remove some comments from the code that were explaining functionality from
  external tools that are already rightly documented in their respective
  repositories.

## [2024.12.12]

### Codebase

- Dotfiles are now managed with Nix (via flakes).

### Mario's MacBook Pro

- Most of the system configurations and packages are now managed with Nix. In
  particular:
  - System-wide configurations and packages are managed with
    [nix-darwin](https://github.com/LnL7/nix-darwin).
  - User-specific configurations and packages are managed with
    [home-manager](https://github.com/nix-community/home-manager) as a
    nix-darwin module.

### Development

- Development dependencies are now managed with Nix. In particular:
  - A development shell has been added with
    [devshell](https://github.com/numtide/devshell).
  - Pre-commit hooks have been added with
    [pre-commit-hooks.nix](https://github.com/cachix/pre-commit-hooks.nix/tree/master).
  - A `Justfile` with recipes to format and check the code.

### Documentation

- The README file has been updated to reflect the changes in the codebase and
  development environment.
- The CHANGELOG format no longer adheres to the _Keep a Changelog_
  specification. Instead, it follows a format where each change is grouped by
  the affected area.

## [2024.03.19]

### Codebase

- Initial version of the dotfiles repository using the
  [dotbot](https://github.com/anishathalye/dotbot) tool.

<!-- External links -->
[unreleased]:
  https://github.com/mariovagomarzal/dotfiles/compare/2024.12.12...HEAD
[2024.12.12]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.12.12
[2024.03.19]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.03.19
