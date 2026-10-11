---
name: update-dependencies
description: Update the flake's inputs (all of them or a single one), check that everything still evaluates and builds, and hand over to the user to apply the result. Use when asked to update dependencies, inputs, nixpkgs or flake.lock.
---

# Updating dependencies

1. **Update** every input with `nix flake update`, or a single one with `nix flake update <input>`. Summarise what
   moved from the `flake.lock` diff: which inputs changed and roughly how far.
2. **Check** with `nix flake check`, and build the machines the update can affect that the current machine can build
   (see the commands in `docs/spec/overview.md`); CI evaluates the others on their platform. When something breaks, find out why before fixing it: upstream changelogs, issues and
   recent commits usually explain it. A fix that is only needed until upstream catches up is a workaround, marked as
   the spec describes.
3. **Hand over.** Applying a configuration is left to the user: suggest the apply command for each machine and ask
   them to share any error it prints, so it can be fixed.
4. **Review the workarounds** with the `review-workarounds` skill: an update is when one is most likely to have become
   unnecessary.

The commit, once the user asks for it, is `feat(config): update dependencies`, with any notable change or fix in the
body.
