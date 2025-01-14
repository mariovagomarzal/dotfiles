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

## [2025.01.14]

### Codebase

- Non-standalone user configurations directories now have the '@\<hostname\>'
  suffix to differentiate them from standalone user configurations directories
  and to make it easier to identify the host.

## [2025.01.11.1]

### Documentation

- The logo in the README file has been fixed.

## [2025.01.11]

### Mario's MacBook Pro

- The behavior of some Darwin shared modules is now more general.
- Many system settings options have been added.
- Packages installation options have been reorganized. Now, 'nix-darwin' manages
  less packages in favor of 'home-manager'.
- Now 'home-manager' programs/services use the Catppuccin theme.
- Added the following programs/services for 'home-manager':
  - Bat
  - LSD
  - Visual Studio Code
  - Firefox

### Development

- Some 'Markdownlint' rules have been disabled.

### Documentation

- A logo and some badges have been added to the README file.
- The documentation of the setup process for Mario's MacBook Pro has been
  improved.s

## [2024.12.28]

### Codebase

- Dotfiles have been reorganized. Now, each configuration type, i.e., NixOS,
  Darwin and Home-Manager, has its own directory. Inside each directory, each
  host or user has its own directory too. This structure allows for better
  organization of the modules that make up the configurations.
- The 'configurations-manager' library has been implemented so the system
  configurations can be easily defined and managed according to the new
  structure.

### Development

- The 'internal' category of commands of the 'devshell' tool has been removed.
  The `_pre-commit-install` command is now executed when entering the
  development shell.

### Documentation

- The README file has been updated to reflect the changes in the codebase and
  development environment.
- Some comments from the code that were explaining functionality from
  external tools that are already rightly documented in their respective
  repositories have been removed.

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
[2025.01.14]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.01.14
[2025.01.11.1]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.01.11.1
[2025.01.11]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.01.11
[2024.12.28]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.12.28
[2024.12.12]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.12.12
[2024.03.19]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.03.19
