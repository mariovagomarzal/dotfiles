{flake, ...}: let
  inherit
    (flake.lib.modules)
    modulesWithout
    ;
in {
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  host = {
    hostname = "Marios-MBP";
    computername = "Mario's MacBook Pro";
  };

  users.users = {
    "mariovagomarzal" = {
      uid = 501;
      home = "/Users/mariovagomarzal";
      description = "Mario Vago Marzal";
    };
  };

  system.primaryUser = "mariovagomarzal";

  imports = modulesWithout {
    "darwin" = [];
    "shared" = [];
  };
}
