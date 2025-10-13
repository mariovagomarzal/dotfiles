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

  # Host information.
  host = {
    hostname = "Marios-MBP";
    computername = "Mario's MacBook Pro";
  };

  # Users information.
  users.users = {
    "mariovagomarzal" = {
      home = "/Users/mariovagomarzal";
      description = "Mario Vago Marzal";
    };
  };

  # Set the primary user of the system.
  system.primaryUser = "mariovagomarzal";

  imports = darwinModulesWithout [];
}
