---
title: Overview
description: How the repository is laid out, the commands to work with it, and what this spec is.
order: 0
---

This spec describes how the repository is organised and the conventions it follows. It changes with the repository: when
a convention gets in the way, for a person or for an agent, changing it here is always an option.

Everything in the repository is written in English: code, comments, documentation and commit messages.

## Layout

The repository is a Nix flake that uses [Blueprint](https://github.com/numtide/blueprint) to map folders to outputs.
`flake.nix` and `flake.lock` stay at the root; the Nix configuration lives under `nix/`.

| Path                                       | Contents                                                          |
| ------------------------------------------ | ----------------------------------------------------------------- |
| `nix/hosts/<host>/configuration.nix`       | A NixOS machine                                                    |
| `nix/hosts/<host>/darwin-configuration.nix` | A macOS machine, with nix-darwin                                  |
| `nix/hosts/<host>/users/<user>.nix`        | A home-manager user on that machine                               |
| `nix/modules/<module>/<class>.nix`         | Configuration, one directory per feature (see [Modules](/spec/modules)) |
| `nix/packages/<name>.nix`                  | Packages and tools of the repository                              |
| `nix/checks/`, `nix/formatter.nix`, `nix/devshell.nix` | Flake checks, formatter and development shell        |
| `docs/`                                    | This documentation site and its spec                              |

A host with a system configuration gets home-manager for its users. A host with only `users/` is a machine managed by
home-manager alone, on any Linux or macOS.

## Commands

| Task                                  | Command                                                          |
| ------------------------------------- | ---------------------------------------------------------------- |
| Format everything                     | `nix fmt`                                                        |
| Run the checks: evaluation, formatting, lints | `nix flake check`                                        |
| Build a machine without applying it   | `nix build .#darwinConfigurations.<host>.system`, `.#nixosConfigurations.<host>.config.system.build.toplevel` or `.#homeConfigurations."<user>@<host>".activationPackage` |
| Apply a machine                       | `sudo darwin-rebuild switch --flake .`, `sudo nixos-rebuild switch --flake .` or `home-manager switch --flake .` |
| Work on this site                     | `nix run .#dotfiles-docs -- dev`, or `build` and `preview`       |

Applying a configuration is left to the person at the machine. Entering the development shell with `nix develop` installs
the git hooks that format files and check commit messages.
