<h3 align="center">
  <img alt="Logo" src="https://raw.githubusercontent.com/mariovagomarzal/dotfiles/main/.github/assets/logo.svg" width="150">
  <br/>
  <br/>
  <a href="https://github.com/mariovagomarzal">Mario</a>'s dotfiles repository
</h3>

<p align="center">
  <img alt="Built with Nix" src="https://img.shields.io/badge/-Built_with_Nix-_?style=for-the-badge&logo=nixos&logoColor=%2389b4fa&labelColor=%23313244&color=%2389b4fa">
  <img alt="GitHub Tag" src="https://img.shields.io/github/v/tag/mariovagomarzal/dotfiles?sort=date&style=for-the-badge&label=Tag&labelColor=%23313244&color=%23a6e3a1">
  <img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/mariovagomarzal/dotfiles?style=for-the-badge&labelColor=%23313244&color=%23f9e2af">
  <img alt="GitHub License" src="https://img.shields.io/github/license/mariovagomarzal/dotfiles?style=for-the-badge&labelColor=%23313244&color=%23f38ba8">
</p>

&nbsp;

<details open>
  <summary>Configurations previews</summary>
  <br/>
  <p align="center">
    <img alt="Marios-MBP preview (WIP)" src="">
  </p>
</details>

&nbsp;

## Table of contents

- [📖 About this repository](#about-this-repository)
  - [Repository structure](#repository-structure)
- [🚀 Setup](#setup)
  - [Mario's MacBook Pro](#marios-macbook-pro-marios-mbp)
- [👨‍💻 Development](#development)
  - [Environment](#environment)
  - [Workflow and conventions](#workflow-and-conventions)

## About this repository

This repository serves as my _personal_ dotfiles for setting up a new machine.
This includes many system settings and the installation and configuration of
most of the tools and applications I use on a daily basis on each of the
machines handled by this repository.

> [!IMPORTANT]
> As mentioned, these dotfiles are tailored to my personal needs and
> preferences. Therefore, in most cases, they will not be suitable for anyone
> else. However, feel free to use them as a starting point for your own
> dotfiles. This guide is intended to be a reference for myself, but also for
> anyone else who might find it useful to build their own dotfiles.

This dotfiles repository contains configurations for my NixOS and Darwin (macOS)
machines. The configurations are managed with [Nix][nix], with this repository
serving as a [Nix flake][nix-flake] whose outputs are the machine
configurations.

### Repository structure

This repository's flake uses [Snowfall Lib][snowfall-lib], a library that
automatically generates flake outputs based on file organization by imposing an
opinionated directory structure.

Below is a schematic overview of the repository's main directory structure. For
comprehensive details on how Snowfall Lib works, please refer to the [official
documentation][snowfall-lib].

```text
dotfiles/
├── flake.nix                       # Flake definition file.
├── modules/                        # NixOS, Darwin, and Home-Manager modules.
│   ├── nixos/                      # NixOS modules.
│   ├── darwin/                     # Darwin (macOS) modules.
│   └── home-manager/               # Home-Manager modules.
├── systems/                        # System configurations.
│   └── <system_architecture>/      # Machine architecture (e.g., x86_64-linux).
│       └── <system_name>/          # Machine name (e.g., MyPC).
├── homes/                          # Home-Manager configurations.
│   └── <system_architecture>/      # Machine architecture (e.g., x86_64-linux).
│       └── <user_name>/            # User name (e.g., johndoe).
├── shells/                         # Development shells.
└── checks/                         # Flake checks.
```

Check the specific directories in this repository to see which modules, systems,
and homes are currently available.

## Setup

In this section, we will describe how to setup each of the machines handled by
this repository.

> [!WARNING]
> The following instructions will install and configure many tools and
> applications on your machine. Make sure to read and understand what the setup
> process does before running it.

### Mario's MacBook Pro (Marios-MBP)

<details open>
  <summary>Configuration preview</summary>
  <br/>
  <p align="center">
    <img alt="Marios-MBP preview (WIP)" src="">
  </p>
</details>
<br/>

We're going to describe the setup process for my (Mario's) MacBook Pro. We will
assume a fresh installation of macOS.

1. __Disable System Integrity Protection (SIP)__: The [Yabai][yabai] window
  manager require partially disabling System Integrity Protection (SIP). To do
  so, we have to boot into recovery mode. Once in recovery mode, we have to open
  the terminal and run the following command and then reboot:

    ```bash
    csrutil enable --without fs --without debug --without nvram
    ```

    For Apple Silicon machines, we also have to enable non-Apple-signed arm64e
    binaries. To do so, we have to run the following command and then reboot:

    ```bash
    sudo nvram boot-args=-arm64e_preview_abi
    ```

2. __Restore SSH keys__: I use [SSH keys][ssh-keys] to authenticate with GitHub
  and other services. For that reason, we will need to safely restore the SSH
  keys from a backup or [generate new ones][generate-ssh-keys] and store them
  in the `~/.ssh` directory.

3. __Install Xcode Command Line Tools__: For the setup process, we will need to
  install the Xcode Command Line Tools, since they may be required in some
  of the following steps. To do so, run the following command in the terminal:

    ```bash
    xcode-select --install
    ```

4. __Install Homebrew__: Some packages are installed via [Homebrew][homebrew] by
  nix-darwin. However, nix-darwin will not install Homebrew itself. To install
  Homebrew follow the instructions in the [official download
  page][download-brew] or TL;DR, run the following command in the terminal:

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

5. __Install Nix__: We will use Nix to setup and manage the machine
  configuration. Install Nix following the instructions in the [official
  download page][download-nix].

6. __Clone the repository__: Once Nix is installed and the SSH keys are in
  place, we can clone the repository with Git (or by manually downloading it)
  and `cd` into it:

    ```bash
    git clone https://github.com/mariovagomarzal/dotfiles.git
    cd dotfiles
    ```

7. __Setup the machine__: If it is the first time we're setting up the machine
  with these dotfiles, we have to run the following command:

    ```bash
    sudo nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '.#Marios-MBP'
    ```

If the last command succeeds, the machine should be fully configured with the
dotfiles. From now on, we can update the machine by running the following
_Just_ recipe:

```bash
just darwin-rebuild # or simply 'just dr'
```

#### Extra optional manual steps

Here we will describe some extra optional manual steps which are not automated
by the dotfiles.

<details>
  <summary>Firefox</summary>

- __Stylus user styles__: The [Stylus][stylus] extension is used to apply
  custom styles to web pages. We use a curated list of user styles from the
  [Catppuccin community][catppuccin]. In this [website][catppuccin-styles] we
  can select the styles (and its flavors) we want to apply to get an
  `import.json` file. Then we have to use this file with Stylus to apply the
  styles.

</details>

## Development

In this section, we will describe how to setup the development environment, the
workflows and the conventions used in this repository.

### Environment

The repository flake defines a development shell with all the necessary tools
and configurations to work with the repository. Assuming that Nix is installed,
you can enter the development shell by running the following command:

```bash
nix --extra-experimental-features 'nix-command flakes' develop
```

> [!TIP]
> The `--extra-experimental-features 'nix-command flakes'` flag is only needed
> if this features are no enabled by default in your Nix installation.

If the command succeeds, you will see a welcome message with a list of the
available tools and commands. You can type `menu` to see the list of available
commands again in any moment.

When entering the development shell, some git hooks are automatically installed
to help with the workflow and conventions described in the next sections.

However, most of the tasks related to the development are defined in the
`Justfile` file. You can see the list of available tasks by simply running
`just`. Development-related recipes are defined under the `development`
category.

> [!NOTE]
> See the [Just documentation][just] for more information about how to use
> the Just command runner. You can also check the `Justfile` file for
> seeing how the tasks are defined.

### Workflow and conventions

Next, we will describe the workflow and conventions used in this repository.

> [!NOTE]
> Before version [2025.08.14], there were no strict rules for commit messages,
> branching, or other aspects of the workflow. This may be reflected in the
> commit history and other parts of the repository.

#### Commit messages

Commit messages follow the [Conventional Commits
specification][conventional-commits], adapted to the context of a dotfiles
repository. This ensures a consistent and readable commit history.

The standard format remains the same:

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

We use the conventional commit types, where `feat` and `fix` take on meanings
appropriate for dotfiles, like `feat` for adding new configurations, modules, or
capabilities, and `fix` for correcting broken configurations or resolving
issues. Other standard types (`docs`, `style`, `refactor`, `perf`, `test`,
`build`, `ci`, `chore`) are used with their usual meanings.

Scopes identify which part of the repository is affected and follow specific
patterns depending on the part of the configuration (if any) being changed:

- Module changes in the `modules/` directory use simple platform identifiers:
  `nixos`, `darwin`, or `home`. For example: `feat(nixos): add new firewall
  module` or `fix(home): correct git module structure`.

- System configurations in the `systems/` directory use the format
  `system/<name>`, such as `fix(system/Marios-MBP): update display settings`.

- Home configurations in the `homes/` directory follow the pattern
  `user/<name>`, like `feat(user/mariovagomarzal): add starship config`.

- General changes use broader scopes:
  - `config` for general configuration changes not specific to a module, system,
    or home (flake-level changes, overlays, inputs, structure, etc.).
  - `lib` for changes related to the custom Nix library, stored in `lib/`.
  - `overlays` for changes to package overlays, stored in `overlays/`.
  - `packages` for changes to custom packages, stored in `packages/`.
  - `shells` for changes to development shells, stored in `shells/`.
  - `checks` for changes to flake checks, stored in `checks/`.

Other scopes can be used as needed.

> [!TIP]
> A git hook automatically validates commit messages against this specification.

#### Branching

There are no strict rules for branching in this repository. The `main` branch
holds the stable version of the dotfiles. Small changes can be committed
directly to the `main` branch, while larger changes are recommended to be
developed in separate feature branches.

Every stable version of the dotfiles must be tagged with a version tag, whose
format is described in the next section.

#### Changelog

All notable changes to this project will be documented in the
[`CHANGELOG.md` file][changelog]. The format of the changelog is described in
the file itself.

The changelog is generated automatically with [git-cliff][git-cliff]. Use the
following Just recipe to update the changelog:

```bash
just changelog
```

> [!IMPORTANT]
> Use the following commit message when updating the changelog so that it is
> ignored by git-cliff:
>
> ```text
> chore: update the changelog
> ```

#### Versioning

Although Conventional Commits are used for commit messages, this repository does
not follow Semantic Versioning for versioning. Instead, each stable version of
the dotfiles repository is tagged with a date in the format `YYYY.MM.DD(.P)`,
where `P` is an optional patch version separated by a dot if more than one
version is released in the same day.

Use the following Just recipe to create a new version tag:

```bash
just tag
```

> [!IMPORTANT]
> The tag is obtained by reading the changelog. Thus, make sure that the
> changelog is up to date before creating a new tag.

&nbsp;

---

<p align="center">
  Licensed under the <a href="/LICENSE">MIT License</a> by Mario Vago Marzal.
</p>

<!-- External links -->
[nix]: https://nixos.org/
[nix-flake]: https://nixos.wiki/wiki/Flakes
[snowfall-lib]: https://snowfall.org/guides/lib/quickstart/
[yabai]:
  https://github.com/koekeishiya/yabai
[ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh
[generate-ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
[homebrew]: https://brew.sh
[download-brew]: https://brew.sh
[download-nix]: https://nixos.org/download
[stylus]: https://addons.mozilla.org/en-US/firefox/addon/styl-us
[catppuccin]: https://catppuccin.com/
[catppuccin-styles]: https://catppuccin-userstyles-customizer.uncenter.dev/
[just]: https://just.systems/man/en/
[2025.08.14]:
  https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.08.14
[conventional-commits]: https://www.conventionalcommits.org/en/v1.0.0/
[changelog]: /CHANGELOG.md
[git-cliff]: https://git-cliff.org/
