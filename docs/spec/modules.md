---
title: Modules
description: Module layout, host imports, docstrings and comments.
order: 1
---

## Layout

Configuration lives in `nix/modules/<feature>/<class>.nix`: one directory per feature, named after the program or
service it configures (`zed`, `fish`, `homebrew`), with one file per class. A large class can be a directory with a
`default.nix` instead of a single file.

| File               | Class                                         | Imported by          |
| ------------------ | --------------------------------------------- | -------------------- |
| `home.nix`         | home-manager, on any platform                 | users                |
| `home-darwin.nix`  | home-manager, on macOS only                   | users on darwin      |
| `darwin.nix`       | nix-darwin                                    | darwin hosts         |
| `nixos.nix`        | NixOS                                         | NixOS hosts          |

Blueprint exposes each file as `flake.modules.<feature>.<class>`.

- **Hosts import modules explicitly.** `nix/hosts/<host>/darwin-configuration.nix` and
  `nix/hosts/<host>/users/<user>.nix` list the modules they use. To add a module, create its directory and import it
  from each host that needs it. A host that imports a missing module fails to evaluate.
- **External modules are imported where they are used.** For example, the `neovim` module imports nixvim's module.
- **Custom options are declared in the module that uses them**, and only when plain configuration is not enough.
- **There is no shared class yet.** System-level configuration goes in `darwin.nix` until there is a NixOS host.

## Docstrings

Every class file opens with an [RFC 145](https://github.com/NixOS/rfcs/pull/145) doc comment, written in Markdown:

```nix
/**
Zed in Vim mode, with extensions for Nix, Lean 4, Typst and LaTeX and the
Nix language servers.
*/
{pkgs, ...}: {
  programs.zed-editor = { ... };
}
```

- **The first paragraph is a one-sentence summary** of what the file configures. It appears in module lists and on host
  pages.
- **Further paragraphs** explain anything the code does not, such as the reason for an approach or a known limitation.
- **Do not list programs, packages or importing hosts.** The documentation site computes them from the configuration,
  and takes history from git.

## Comments

Use `#` comments only for information the code does not convey: a reason, a pending `TODO`, or the meaning of an opaque
value. Avoid comments that restate the code, section banners and file headers.
