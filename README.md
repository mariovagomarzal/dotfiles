# [Mario][mario]'s dotfiles

My personal dotfiles for setting up a new machine.

## Table of contents

- [📖 About this repository](#about-this-repository)
  - [Repository structure](#repository-structure)
  - [The 'configurations-manager' library](#the-configurations-manager-library)
- [🚀 Setup](#setup)
  - [Mario's MacBook Pro](#marios-macbook-pro)
- [👨‍💻 Development](#development)
  - [Environment](#environment)
  - [Workflow and conventions](#workflow-and-conventions)
- [📝 License](#license)

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

We're going to describe the setup process for my (Mario's) MacBook Pro. We will
assume a fresh installation of macOS.

In first place, install Nix following the instructions in the [official download
page][download-nix].

I use [SSH keys][ssh-keys] to authenticate with GitHub and other services. For
that reason, we will need to safely restore the SSH keys from a backup or
[generate new ones][generate-ssh-keys] and store them in the `~/.ssh` directory.

Once Nix is installed and the SSH keys are in place, we can clone the repository
with Git if installed, or by manually downloading the repository. Then, we `cd`
into it:

```sh
git clone https://github.com/mariovagomarzal/dotfiles.git
cd dotfiles
```

If it is the first time we're setting up the machine with these dotfiles, we
have to run the following command:

```sh
nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '.#Marios-MacBook-Pro'
```

If this command succeeds, the machine should be fully configured with the
dotfiles. From now on, we can update the machine by running the following
_Just_ recipe:

```sh
just darwin-rebuild # or simply 'just dr'
```

## Development

In this section, we will describe how to setup the development environment, the
workflows and the conventions used in this repository.

### Environment

To work with this repository, as we are using Nix with flakes, a development
shell with the necessary tools and configurations has been defined in the
`development.nix` file as a submodule of the main flake.

Assuming that you have Nix installed, you can enter the development shell by
running the following command:

```sh
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

## License

This repository is licensed under the [MIT License](/LICENSE) by [Mario Vago
Marzal][mario].

<!-- External links -->
[mario]: https://github.com/mariovagomarzal
[nix]: https://nixos.org/
[nix-flakes]: https://nixos.wiki/wiki/Flakes
[flake-parts]: https://github.com/hercules-ci/flake-parts
[cm-library]: /configurations-manager/default.nix
[download-nix]: https://nixos.org/download/
[ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh
[generate-ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
