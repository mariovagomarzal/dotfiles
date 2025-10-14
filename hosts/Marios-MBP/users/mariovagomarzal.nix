################################################################################
# Mario Vago Marzal's (mariovagomarzal) home configuration for aarch64-darwin. #
################################################################################
{flake, ...}: let
  inherit
    (flake.lib.modules)
    modulesWithout
    ;
in {
  home.stateVersion = "25.05";

  imports = modulesWithout {
    "home" = [];
    "home-darwin" = [];
  };
}
