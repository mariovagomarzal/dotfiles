###################################################
# Mario's MacBook Pro (Marios-MBP) Darwin system. #
###################################################
{flake, ...}: let
  inherit
    (flake.lib.modules)
    darwinModulesWithout
    ;
in {
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Specific host information.
  host = {
    hostname = "Marios-MBP";
    computername = "Mario's MacBook Pro";
  };

  # Specific users information.
  system.primaryUser = "mariovagomarzal";

  imports = darwinModulesWithout [];
}
