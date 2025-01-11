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
    <img alt="Marios-MacBook-Pro preview (WIP)" src="">
  </p>
</details>

&nbsp;

## Table of contents

- [📖 About this repository](#about-this-repository)
  - [Repository structure](#repository-structure)
  - [The 'configurations-manager' library](#the-configurations-manager-library)
- [🚀 Setup](#setup)
  - [Mario's MacBook Pro](#marios-macbook-pro)
- [👨‍💻 Development](#development)
  - [Environment](#environment)
  - [Workflow and conventions](#workflow-and-conventions)

## About this repository

This repository serves as my _personal_ dotfiles for setting up a new machine.
This includes many system settings and the installation and configuration of
most of the tools and applications I use on a daily basis on each of the
machines handled by this repository.

> [!NOTE]
> As mentioned, these dotfiles are tailored to my personal needs and
> preferences. Therefore, in most cases, they will not be suitable for anyone
> else. However, feel free to use them as a starting point for your own
> dotfiles. This guide is intended to be a reference for myself, but also for
> anyone else who might find it useful to build their own dotfiles.

I use [Nix][nix] to manage the dependencies and configurations for the tools and
applications included in these dotfiles. This approach provides a reproducible
and declarative way to set up a new machine. Specifically, I leverage the
[Flakes][nix-flakes] feature in Nix, which ensures that dependencies are
version-pinned, further enhancing the reproducibility of the setup.

### Repository structure

In addition to the benefits described above, the Flake approach enables
centralized and organized definitions for system configurations, development
environments, and other workflows.

The `flake.nix` file serves as the flake's entry point. It defines the flake's
dependencies (inputs) and outputs, such as system configurations and development
tools. However, these outputs are actually implemented in separate files.

The development.nix file specifies tools like pre-commit and development shells,
utilizing [flake-parts][flake-parts]. For more details, refer to the
[Development](#development) section.

System configurations are defined in the `system-configs.nix` file and managed
using the custom 'configurations-manager' library (see
[below](#the-configurations-manager-library)). Each type of configuration has
its own directory:

- __NixOS configurations__ are stored in `nixos-configurations/`.
- __Darwin configurations__ are stored in `darwin-configurations/`.
- __Home-Manager configurations__ are stored in `home-configurations/`.

At the top level of each directory, shared modules for all hosts/users of that
configuration type are defined. Within these directories, subdirectories are
used to store host- or user-specific configurations.

This structure provides a clear overview of the components comprising each
configuration managed by these dotfiles.

<details>
<summary>Repository file tree</summary>

```text
dotfiles
├── configurations-manager
│   ├── default.nix
│   ├── home-makers.nix
│   ├── system-makers.nix
│   └── utils.nix
├── darwin-configurations
│   ├── Marios-MacBook-Pro
│   │   ├── packages.nix
│   │   └── system.nix
│   ├── host-users.nix
│   └── nix-core.nix
├── home-configurations
│   ├── firefox
│   │   ├── profiles
│   │   │   └── default.nix
│   │   └── default.nix
│   ├── mariovagomarzal
│   │   ├── core.nix
│   │   ├── firefox.nix
│   │   ├── git.nix
│   │   ├── skhd.nix
│   │   ├── ssh.nix
│   │   └── yabai.nix
│   ├── vscode
│   │   ├── default.nix
│   │   ├── global-snippets.nix
│   │   ├── keybindings.nix
│   │   ├── language-snippets.nix
│   │   ├── user-settings.nix
│   │   └── user-tasks.nix
│   ├── alacritty.nix
│   ├── bat.nix
│   ├── core.nix
│   ├── fish.nix
│   ├── git.nix
│   ├── lsd.nix
│   └── starship.nix
├── nixos-configurations
├── .gitignore
├── CHANGELOG.md
├── development.nix
├── flake.lock
├── flake.nix
├── Justfile
├── LICENSE
├── README.md
└── system-configs.nix
```

</details>

### The 'configurations-manager' library

The 'configurations-manager' library is a custom tool designed to leverage the
repository structure described above, making it easy to locate and manage the
required files for each configuration.

This library is implemented in the `configurations-manager/` directory. For a
detailed explanation of its usage, refer to the
[configurations-manager/default.nix][cm-library] file, which defines the three
primary functions for creating configurations:

- `mkNixosConfigurations`: Used to define NixOS configurations.
- `mkDarwinConfigurations`: Used to define Darwin configurations.
- `mkHomeConfigurations`: Used to define standalone Home-Manager configurations.

An example of how to use this library can be found in the `system-configs.nix`
file. This file also provides additional details on how the configurations in
this repository are structured and defined.

## Setup

In this section, we will describe how to setup each of the machines and/or users
handled by this repository.

> [!CAUTION]
> The following instructions will install and configure many tools and
> applications on your machine. Make sure to read and understand what the setup
> process does before running it.

### Mario's MacBook Pro

<details open>
  <summary>Configuration preview</summary>
  <br/>
  <p align="center">
    <img alt="Marios-MacBook-Pro preview (WIP)" src="">
  </p>
</details>
<br/>

We're going to describe the setup process for my (Mario's) MacBook Pro. We will
assume a fresh installation of macOS.

1. __Restore SSH keys__: I use [SSH keys][ssh-keys] to authenticate with GitHub
  and other services. For that reason, we will need to safely restore the SSH
  keys from a backup or [generate new ones][generate-ssh-keys] and store them
  in the `~/.ssh` directory.

2. __Install Xcode Command Line Tools__: In first place, we will need to
  install the Xcode Command Line Tools, since they may be required in some
  of the following steps. To do so, run the following command in the terminal:

    ```console
    xcode-select --install
    ```

3. __Install Homebrew__: Some packages are installed via [Homebrew][homebrew] by
  nix-darwin. However, nix-darwin will not install Homebrew itself. To install
  Homebrew follow the instructions in the [official download
  page][download-brew] or TL;DR:

    ```console
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

4. __Install Nix__: We will use [Nix][nix] to setup and manage the machine
  configuration. Install Nix following the instructions in the [official
  download page][download-nix].

5. __Clone the repository__: Once Nix is installed and the SSH keys are in
  place, we can clone the repository with Git (or by manually downloading it)
  and `cd` into it:

    ```console
    git clone https://github.com/mariovagomarzal/dotfiles.git
    cd dotfiles
    ```

6. __Setup the machine__: If it is the first time we're setting up the machine
  with these dotfiles, we have to run the following command:

    ```console
    nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '.#Marios-MacBook-Pro'
    ```

If this command succeeds, the machine should be fully configured with the
dotfiles. From now on, we can update the machine by running the following
_Just_ recipe:

```console
just darwin-rebuild # or simply 'just dr'
```

#### Extra optional manual steps

Here we will describe some extra optional manual steps which are not automated
by the dotfiles.

<details>
  <summary>Firefox</summary>

- __Firefox Color theme__: The [Firefox Color][firefox-color] extension is
  used to customize the browser's theme. We use the [Catppuccin Firefox
  port][catppuccin-firefox] theme. To apply the theme, follow the steps
  described in the repository's README.
- __Stylus user styles__: The [Stylus][stylus] extension is used to apply
  custom styles to web pages. We use a curated list of user styles from the
  [Catppuccin community][catppuccin]. In this [website][catppuccin-styles] we
  can select the styles (and its flavors) we want to apply to get an
  `import.json` file. Then we have to use this file with Stylus to apply the
  styles.

</details>

<details>
  <summary>Visual Studio Code</summary>

The following extensions should be installed manually:

- [Reload][reload-vscode]

</details>

## Development

In this section, we will describe how to setup the development environment, the
workflows and the conventions used in this repository.

### Environment

To work with this repository, as we are using Nix with flakes, a development
shell with the necessary tools and configurations has been defined in the
`development.nix` file as a submodule of the main flake.

Assuming that you have Nix installed, you can enter the development shell by
running the following command:

```console
nix --extra-experimental-features 'nix-command flakes' develop
```

The `--extra-experimental-features 'nix-command flakes'` flag is only needed if
this features are no enabled by default in your Nix installation.

If the command succeeds, you will see a welcome message with a list of the
available tools and commands. You can type `menu` to see the list of available
commands again in any moment. Finally, you can exit the shell by typing `exit`.

In addition to that, some other basic tasks related to the development are
defined in a `Justfile`. You can see the list of available tasks (under the
`development` category) by simply running `just`.

### Workflow and conventions

This repository follows a simple (and flexible) workflow:

- The main branch (`main`) holds the stable version of the dotfiles. These
  versions must be tagged with a format like `YYYY.MM.DD`, with optional patch
  versions separated by a dot if more than one version is released in the same
  day.
  - Small changes can be committed directly to the main branch.
  - Larger changes are recommended to be developed in separate feature branches.
- All changes should be documented in the [`CHANGELOG.md` file](/CHANGELOG.md).
  The format of the changelog is described in the file itself.

&nbsp;

---

<p align="center">
  Copyright &copy; 2024-present Mario Vago Marzal
</p>

<!-- External links -->
[nix]: https://nixos.org/
[nix-flakes]: https://nixos.wiki/wiki/Flakes
[flake-parts]: https://github.com/hercules-ci/flake-parts
[cm-library]: /configurations-manager/default.nix
[ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh
[generate-ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
[homebrew]: https://brew.sh
[download-brew]: https://brew.sh
[download-nix]: https://nixos.org/download
[firefox-color]: https://addons.mozilla.org/en-US/firefox/addon/firefox-color
[catppuccin-firefox]: https://github.com/catppuccin/firefox
[stylus]: https://addons.mozilla.org/en-US/firefox/addon/styl-us
[catppuccin]: https://catppuccin.com/
[catppuccin-styles]: https://catppuccin-userstyles-customizer.uncenter.dev/
[reload-vscode]: https://marketplace.visualstudio.com/items?itemName=natqe.reload
