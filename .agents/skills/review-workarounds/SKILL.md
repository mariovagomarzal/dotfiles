---
name: review-workarounds
description: Find the workarounds marked in the configuration and check whether each one is still needed, removing those that are not. Use when asked to review workarounds, temporary fixes, overlays or pins, and after updating dependencies.
---

# Reviewing workarounds

Workarounds are marked in the code with a comment in the format the spec describes:

```nix
# workaround: <what and why>. Remove when <condition> (<link>).
```

1. **Find them** with `rg -n 'workaround:'`.
2. **Check each condition** in whatever way it allows: the state of the linked issue or pull request (`gh issue view`,
   `gh pr view`), the version a fix landed in against the current one (`nix eval`), or simply removing the workaround
   and building the affected machine.
3. **Remove the ones that are no longer needed**, together with anything that only existed for them, and check again.
   Keep the rest, updating the condition or the link if it has changed.
4. **Report** briefly: each workaround, what was found, and what was done.
