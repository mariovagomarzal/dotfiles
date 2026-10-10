---
title: Secrets
description: How secrets are stored, decrypted and added.
order: 3
---

## How it works

Secrets are kept in the repository encrypted with [sops](https://github.com/getsops/sops) and decrypted when a machine
applies its configuration, by [sops-nix](https://github.com/Mic92/sops-nix).

- **Each module keeps its own secrets** in `nix/modules/<module>/secrets.yaml`, so removing a module removes its
  secrets too. Key names stay readable; only values are encrypted.
- **Every secrets file is encrypted for several age keys**, listed in `.sops.yaml`: one per machine, readable only by
  root on that machine, and a recovery key kept outside the repository by its owner.
- **Values never appear in the configuration.** A module declares a secret by name, and whatever needs it reads the
  path sops-nix gives, through `config.sops.secrets.<name>.path` or a template's `config.sops.templates.<name>.path`.
- **The `sops` module owns the key's location**; anything else that needs it derives it from `config.sops.age.keyFile`.

## Adding a secret

1. **Declare it** in the module that uses it, named after the module:

   ```nix
   sops.secrets."<module>/<name>" = {
     sopsFile = ./secrets.yaml;
     key = "<name>";
   };
   ```

   When a program expects the value inside a larger file, render that file with `sops.templates` and
   `config.sops.placeholder."<module>/<name>"`.
2. **Write the value** with `sops edit nix/modules/<module>/secrets.yaml`. This is always done by a person: `sops` reads
   the machine key through `sudo`.
3. **Apply the configuration**, and check the result without reading the value, for example the file's owner and mode.

## Boundaries

- **Decrypted secrets readable by a user must be of low value**: anything running as that user can read them. Secrets
  that only system services need stay owned by root.
- **Agents handle only the plumbing:** declarations, templates, `.sops.yaml` and checks on key names. The machine key is
  readable only by root, and the agents' own rules stop them from decrypting or editing values.
- **Machines managed by home-manager alone** have no root-owned configuration, so their secrets would be decrypted with
  sops-nix's home-manager module and a key of the user: anything running as that user can read them, so they can only
  hold low-value secrets. None is set up yet.
- **A new machine** gets its key on its first activation with a secret declared. Its public key is then added to
  `.sops.yaml`, and the files are re-encrypted with `sops updatekeys` from a machine that can decrypt them, or with the
  recovery key.
