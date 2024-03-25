# [Mario][mario]'s dotfiles

My personal dotfiles for setting up a new machine.

## Table of contents

- [📖 About this repository](#about-this-repository)
- [🚀 Setup](#setup)
  - [Mario's MacBook Pro](#marios-macbook-pro)
- [👨‍💻 Development](#development)
- [📝 License](#license)

## About this repository

This repository serves as my _personal_ dotfiles for setting up a new machine.
This includes many system settings and the installation and configuration of
most of the tools and applications I use on a daily basis on each of the
machines handled by this repository.

> [!NOTE] As mentioned, these dotfiles are tailored to my personal needs and
> preferences. Therefore, in most cases, they will not be suitable for anyone
> else. However, feel free to use them as a starting point for your own
> dotfiles. This guide is intended to be a reference for myself, but also for
> anyone else who might find it useful to build their own dotfiles.

I use [Nix][nix] to manage the dependencies and configurations of the tools and
applications installed by these dotfiles. This allows me to have a reproducible
and declarative way to setup a new machine.

The repository is organized as follows:

- `flake.nix`: The main flake file that defines the inputs and outputs of the
  flake. This file is used by Nix to build the machines configurations and
  others. A `flake.lock` file is also generated by Nix to lock the versions of
  the inputs and guarantee reproducibility.
- `development.nix`: A flake submodule that defines the development shell with
  the necessary tools and configurations for working with this repository.
- `Justfile`: A file that defines the recipes that can be run with the `just`
  command runner. This file contains two types of recipes: dotfiles setup
  related recipes and development related recipes.
- `darwin-configurations`: A directory that contains the configurations for
  Darwin (macOS) machines. Each file in this directory is a Nix module that
  defines the configuration for a specific host. The `modules/` and the `home/`
  directories contain the modules and the home-manager configurations,
  respectively.
- Other general files and directories like `LICENSE`, `README.md`, etc.

## Setup

In this section, we will describe how to setup each of the machines handled by
this repository.

> [!CAUTION]
> The following instructions will install and configure many tools and
> applications on your machine. Make sure to read and understand what the
> setup process does before running it.

### Mario's MacBook Pro

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
available tools and commands. There is an special category of commands,
`internal`, that should not be used directly. You can type `menu` to see the
list of available commands again in any moment. Finally, you can exit the shell
by typing `exit`.

Here is a list of the available commands:

- `menu`: Show the list of available commands.
- `just`: Just is a command runner that can be used to run the recipes defined
  in the `Justfile`. You can type `just` to see the list of available recipes.
  However, it is recommended to take a look at the `Justfile` to see which
  recipes are related to the development of this repository. In any case, here
  is a list of those recipes:
  - `just setup-env`: Setup the development environment by installing the
    pre-commit hooks. Should be run after entering the development shell for
    the first time.
  - `just check`: Run the flake checks.
  - `just format`: Format the Nix files.

### Workflow

The git workflow used in this repository is based on the [Feature branch
workflow][feauture-branch-workflow]. The main steps are:

1. Create a new branch from `main` to work on an specific change.
2. Make the changes and commit them to the branch.
3. Push the branch to the remote repository.
4. Merge the branch into `main` once the changes are ready.
5. Tag the commit with the version number. See the [Versioning](#versioning)
   section for more details.

### Versioning

The versioning of this repository is based on the [CalVer][calver] convention.
The version number is defined as `YYYY.0M.0D`.

### Changelog

We use a [changelog file](/CHANGELOG.md) to keep track of the changes made to
the repository. The changelog follows the [Keep a Changelog][keep-a-changelog]
format.

## License

This repository is licensed under the [MIT License](/LICENSE) by [Mario Vago
Marzal][mario].

<!-- External links -->
[mario]: https://github.com/mariovagomarzal
[nix]: https://nixos.org/
[feauture-branch-workflow]:
  https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
[calver]: https://calver.org/
[keep-a-changelog]: https://keepachangelog.com/
