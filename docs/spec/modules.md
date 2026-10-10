---
title: Modules
description: Module layout, how hosts import modules, docstrings and comments.
order: 1
---

## Layout

Configuration lives in `nix/modules/<module>/<class>.nix`: one directory per feature, named after the program or service
it configures (`git`, `fish`, `firefox`), with one file per class. A large class can be a directory with a `default.nix`
instead of a single file.

| File               | Class                              | Imported by           |
| ------------------ | ---------------------------------- | --------------------- |
| `nixos.nix`        | NixOS                              | NixOS hosts           |
| `darwin.nix`       | nix-darwin                         | macOS hosts           |
| `home.nix`         | home-manager, on any platform      | users                 |
| `home-linux.nix`   | home-manager, on Linux only        | users on Linux        |
| `home-darwin.nix`  | home-manager, on macOS only        | users on macOS        |

`home-linux.nix` serves NixOS and any other Linux distribution managed by home-manager alone; what only NixOS has goes
in `nixos.nix`.

Blueprint exposes each file as `flake.modules.<module>.<class>`. A setting that only exists on one platform goes in that
platform's file rather than behind a condition. A feature's platform files are written with it, even before a machine of
that platform exists, but nothing evaluates them until a host imports them.

- **Hosts import modules explicitly.** A host's system file and each of its user files list the modules they use. To add
  a module, create its directory and import it from each host or user that needs it; a host that imports a missing module
  fails to evaluate.
- **Everything a feature needs lives in its directory**, in every class: removing the directory and its imports removes
  the feature. External modules are imported by the module that uses them, and custom options are declared there too,
  only when plain configuration is not enough.
- **A feature's settings outside its program belong to it too.** When a feature needs something changed elsewhere — a
  system preference, a key, a login item — its module sets it, overriding with `lib.mkForce` when another module sets
  the same option. The other module keeps its own value and needs no knowledge of the feature, and removing the feature
  brings that value back.
- **An integration between two features usually belongs to the one whose removal should take it away**, reading what it
  needs from the other through `config` or a generic interface such as `$EDITOR`, rather than naming the other program.
  When another place is more natural, it goes there.
- **Lists shared by many features** — `packages`, Homebrew's casks or similar — hold only what needs no configuration.
  An entry that comes to need some moves to a module of its own.
- **System and user packages may overlap**: each layer stands on its own, since root has no user packages and a machine
  managed by home-manager alone has no system ones. Within one layer, a package is installed once.
- **Values have a single source.** A path or value that belongs to one module is defined there and read from `config`
  elsewhere, not written again.

For example, a hypothetical menu bar app, `perch`, whose icons are hidden while `macos` auto-hides the menu bar, keeps
the bar visible from its own module rather than by editing `macos`:

```nix
/**
Perch, a menu bar organiser, with the menu bar always shown so its icons stay visible.
*/
{lib, ...}: {
  homebrew.casks = ["perch"];

  system.defaults.NSGlobalDomain._HIHideMenuBar = lib.mkForce false;
}
```

## Docstrings

Every class file opens with an [RFC 145](https://github.com/NixOS/rfcs/pull/145) doc comment, written in Markdown:

```nix
/**
Git with commit signing, short aliases and global ignores.
*/
{...}: {
  programs.git = { ... };
}
```

- **The first paragraph is a one-sentence summary** of what the file configures. It appears in module lists and on host
  pages.
- **Further paragraphs** explain anything the code does not, such as the reason for an approach or a known limitation.
- **Programs, packages and importing hosts are not listed.** The documentation site computes them from the configuration.

## Comments

Use `#` comments only for information the code does not convey: a reason, a pending `TODO`, or the meaning of an opaque
value. Avoid comments that restate the code, section banners and file headers.

A workaround — an overlay for a broken package, a pinned version, something disabled because of an upstream issue — is
marked so it can be found and removed once it is no longer needed:

```nix
# workaround: <what and why>. Remove when <condition> (<link>).
```
