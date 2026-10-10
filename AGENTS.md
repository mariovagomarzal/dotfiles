# Agents

This repository holds the Nix configuration of one person's machines: NixOS and macOS hosts, their home-manager users,
and machines managed by home-manager alone. The spec in `docs/spec/` describes how it is organised and the conventions
it follows, starting at `docs/spec/overview.md`. Follow it, and update it in the same change when a convention changes.

- Everything in the repository is written in English, whatever language the conversation is in.
- Before configuring something, check what really exists: the documentation and source of the upstream module, and how
  the repository already handles similar cases.
- `nix fmt` formats and `nix flake check` checks the current platform; building the affected machines shows whether a
  change works, for those the current machine can build, and CI evaluates the rest on its platform.
- Ask before committing, pushing, opening a pull request or merging, unless the user has allowed it for the session.
- Applying a configuration (`darwin-rebuild switch`, `nixos-rebuild switch`, `home-manager switch`) is left to the person
  at the machine: suggest the command instead of running it.
- Never read, decrypt or print secret values. Secrets are described in `docs/spec/secrets.md`.
