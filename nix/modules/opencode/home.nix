/**
OpenCode, a coding agent for the terminal, with provider and model selection
left to the user.
*/
{pkgs, ...}: {
  programs.opencode = {
    enable = true;
    mutableSettings = true;

    # workaround: the hash of opencode 2.2.5's node_modules is wrong in nixpkgs,
    # and it differs between Linux and macOS. Remove when nixpkgs has the fix
    # (https://github.com/NixOS/nixpkgs/pull/582675).
    package = pkgs.opencode.overrideAttrs (old: {
      node_modules = old.node_modules.overrideAttrs {
        outputHash =
          if pkgs.stdenv.hostPlatform.isDarwin
          then "sha256-dIveiaiPFGSItwLyeMuPDxTE9gpvvnlTCB/+nG24qCc="
          else "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
      };
    });
  };
}
