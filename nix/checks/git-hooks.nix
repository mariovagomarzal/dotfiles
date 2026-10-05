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

    gitlint.enable = true;
  };
}
