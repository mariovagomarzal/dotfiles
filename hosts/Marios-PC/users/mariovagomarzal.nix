###############################################
# Mario's user (mariovagomarzal) at Marios-PC #
###############################################
{flake, ...}: let
  inherit
    (flake.lib.modules)
    modulesWithout
    ;
in {
  home.stateVersion = "25.05";

  imports = modulesWithout {
    "home" = [
      # TODO: Fix broken custom Obsidian plugins that prevent the configuration
      # to build.
      "obsidian"
    ];
    "home-nixos" = [];
  };
}
