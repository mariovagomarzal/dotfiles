################################################################################
# Mario Vago Marzal's (mariovagomarzal) home configuration for aarch64-darwin. #
################################################################################
{flake, ...}: let
  inherit
    (flake.lib.modules)
    homeModulesWithout
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
    ++ [
      ./ssh.nix
      ./git.nix
      ./firefox.nix
      ./aerospace.nix
    ];
}
