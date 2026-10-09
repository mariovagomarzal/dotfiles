<h3 align="center">
  <img alt="Logo" src=".github/assets/logo.svg" width="150">
  <br/>
  <br/>
  <a href="https://github.com/mariovagomarzal">Mario</a>'s dotfiles repository
</h3>

<p align="center">
  <img alt="Built with Nix" src="https://img.shields.io/badge/-Built_with_Nix-_?style=for-the-badge&logo=nixos&logoColor=%2389b4fa&labelColor=%23313244&color=%2389b4fa">
  <a href="https://dotfiles.mariovagomarzal.com"><img alt="Docs" src="https://img.shields.io/badge/Docs-dotfiles.mariovagomarzal.com-_?style=for-the-badge&labelColor=%23313244&color=%23cba6f7"></a>
  <a href="https://github.com/mariovagomarzal/dotfiles/actions/workflows/ci.yaml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/mariovagomarzal/dotfiles/ci.yaml?branch=main&style=for-the-badge&label=CI&labelColor=%23313244&color=%23a6e3a1"></a>
  <img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/mariovagomarzal/dotfiles?style=for-the-badge&labelColor=%23313244&color=%23f9e2af">
  <img alt="GitHub License" src="https://img.shields.io/github/license/mariovagomarzal/dotfiles?style=for-the-badge&labelColor=%23313244&color=%23f38ba8">
</p>

&nbsp;

## Table of contents

- [📖 About this repository](#about-this-repository)
- [🚀 Setup](#setup)
  - [Mario's MacBook Pro](#marios-macbook-pro-marios-mbp)
- [👨‍💻 Development](#development)

## About this repository

This repository holds the [Nix][nix] configuration of my NixOS and macOS
machines, as a [flake][nix-flake] whose outputs are the machine configurations.
It is maintained mostly with coding agents, following the instructions in
[`AGENTS.md`](AGENTS.md).

How the repository is organised, its conventions, the modules each machine uses
and the changelog are on the [documentation site][docs].

> [!IMPORTANT]
> These dotfiles are tailored to my personal needs and preferences, so they
> will rarely suit anyone else as they are. Feel free to use them as a starting
> point for your own.

## Setup

### Mario's MacBook Pro (Marios-MBP)

We will assume a fresh installation of macOS.

1. __Install Xcode Command Line Tools__:

    ```bash
    xcode-select --install
    ```

2. __Install Nix__: Follow the instructions in the [official download
  page][download-nix].

3. __Clone the repository__ into `~/Projects/mariovagomarzal/dotfiles`, where
  the `dotfiles` command expects it:

    ```bash
    git clone https://github.com/mariovagomarzal/dotfiles.git ~/Projects/mariovagomarzal/dotfiles
    cd ~/Projects/mariovagomarzal/dotfiles
    ```

4. __Set up the machine__: The first time, nix-darwin is run from its flake.
  Homebrew is installed and managed by nix-homebrew, with no manual steps.

    ```bash
    sudo nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '.#Marios-MBP'
    ```

5. __Open the password vault__: Open the KeePassXC vault from iCloud Drive. It
  holds the SSH key used for GitHub and commit signing, served by its SSH
  agent.

6. __Authorise the machine's secrets__: The first activation creates the
  machine's age key. Add its public key to `.sops.yaml`, re-encrypt the secrets
  with the recovery key and apply again, as described in the [secrets
  spec][secrets].

From now on, the machine is updated with:

```bash
sudo darwin-rebuild switch --flake .
```

#### Extra optional manual steps

<details>
  <summary>Firefox</summary>

- __Stylus user styles__: The [Stylus][stylus] extension applies the
  [Catppuccin][catppuccin] user styles. Select the styles and flavors in this
  [website][catppuccin-styles] to get an `import.json` file, and import it in
  Stylus.

</details>

## Development

The flake defines a development shell; entering it installs the git hooks that
format files and check commit messages:

```bash
nix develop
```

Format with `nix fmt` and check with `nix flake check`. The rest of the
commands and conventions are described in the [spec][spec].

&nbsp;

---

<p align="center">
  Licensed under the <a href="/LICENSE">MIT License</a> by Mario Vago Marzal.
</p>

[nix]: https://nixos.org/
[nix-flake]: https://nixos.wiki/wiki/Flakes
[docs]: https://dotfiles.mariovagomarzal.com
[spec]: https://dotfiles.mariovagomarzal.com/spec/overview
[secrets]: https://dotfiles.mariovagomarzal.com/spec/secrets#boundaries
[download-nix]: https://nixos.org/download
[stylus]: https://addons.mozilla.org/en-US/firefox/addon/styl-us
[catppuccin]: https://catppuccin.com/
[catppuccin-styles]: https://catppuccin-userstyles-customizer.uncenter.dev/
