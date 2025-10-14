################################################################################
# Mario Vago Marzal's (mariovagomarzal) home configuration for aarch64-darwin. #
################################################################################
{flake, ...}: let
  inherit
    (flake.lib.modules)
    homeModulesWithout
    typeModulesWithout
    ;
in {
  home.stateVersion = "25.05";

  # No-configuration packages.
  home.packages = [];

  # Minimal configuration-dependent programs and/or services.
  programs = {};
  services = {};

  imports =
    (homeModulesWithout [])
    ++ (typeModulesWithout "home-darwin" []);
}
