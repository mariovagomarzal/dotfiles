---
title: Secrets
description: How secrets are stored, decrypted and added.
order: 3
---

## How it works

Secrets are kept in the repository encrypted with [sops](https://github.com/getsops/sops) and decrypted at activation
by [sops-nix](https://github.com/Mic92/sops-nix).

- **Each module keeps its own secrets** in `nix/modules/<module>/secrets.yaml`, so removing a module removes its
  secrets too. Key names stay readable; only values are encrypted.
- **Every secrets file is encrypted for two age keys**, both listed in `.sops.yaml`: the key of each machine, which is
  readable only by root on that machine, and a recovery key kept in the KeePassXC database.
- **Values never appear in the configuration.** A module declares a secret by name, and whatever needs it reads the
  path sops-nix gives, through `config.sops.secrets.<name>.path` or a template's `config.sops.templates.<name>.path`.
- **The `sops` module owns the key's location.** Anything else that needs it, such as `SOPS_AGE_KEY_CMD`, derives it
  from `config.sops.age.keyFile`.

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
2. **Write the value.** This step is always done by a person, never by an agent:

   ```bash
   sops edit nix/modules/<module>/secrets.yaml
   ```

   `sops` fetches the machine key through `sudo`, so it asks for Touch ID.
3. **Activate**, and check the result without reading the value: the file's owner and mode with `ls -l`, and whether a
   program loads it, for example by counting characters.

## Rules

- **Decrypted secrets readable by the user must be low value.** Anything running as the user can read them, agents
  included. Secrets that only system services need stay owned by root.
- **Agents handle only the plumbing:** declarations, templates, `.sops.yaml` and checks on key names. They never
  decrypt, edit or print a secret value.
- **A new machine** gets its key on its first activation with a secret declared. Its public key is then added to
  `.sops.yaml`, and the files are re-encrypted from a machine that can decrypt them, or with the recovery key, using
  `sops updatekeys`.
