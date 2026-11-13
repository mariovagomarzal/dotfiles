{
  inputs,
  flake,
  system,
  pkgs,
  ...
}:
inputs.git-hooks-nix.lib.${system}.run {
  src = ../..;

  package = pkgs.prek;

  hooks = {
    treefmt = {
      enable = true;
      package = flake.formatter.${system};
    };

    convco = {
      enable = true;
      # workaround: convco 0.7.2 looks for libgit2-experimental, which the
      # libgit2 it is built with does not provide, so it fails to build. That
      # libgit2 is not cached, and one of its checkout tests fails in the macOS
      # sandbox, so its tests are skipped. Remove when nixpkgs builds convco
      # with the experimental SHA-256 support
      # (https://github.com/NixOS/nixpkgs/pull/585314).
      package = pkgs.convco.overrideAttrs (old: {
        buildInputs =
          old.buildInputs
          ++ [
            ((pkgs.libgit2.override {withExperimentalSha256 = true;}).overrideAttrs {doCheck = false;})
          ];
      });
    };
  };
}
