{
  inputs,
  pkgs,
  ...
}:
(inputs.treefmt-nix.lib.evalModule pkgs {
  projectRootFile = "flake.nix";

  programs = {
    # deadnix and statix rewrite code, so alejandra has to run after them.
    deadnix = {
      enable = true;
      priority = 1;
    };
    statix = {
      enable = true;
      priority = 2;
      # Purely stylistic and without an automatic fix.
      disabled-lints = ["repeated_keys"];
    };
    alejandra = {
      enable = true;
      priority = 3;
    };

    rumdl-format.enable = true;
    ruff-format.enable = true;
    just.enable = true;
  };

  settings = {
    formatter.rumdl-format.options = [
      "--no-config"
      "--disable"
      # Line length, duplicate headings, inline HTML and first-line heading.
      "MD013,MD024,MD033,MD041"
    ];
  };
}).config.build.wrapper
