######################################
# System configurations definitions. #
######################################
inputs @ {
  nixpkgs,
  nix-darwin,
  home-manager,
  ...
}: let
  configurations-manager = import ./configurations-manager {
    nixpkgs-lib = nixpkgs.lib;
    inherit
      nixpkgs
      nix-darwin
      home-manager
      ;
    rootDir = ./.;
  };
in {
  darwinConfigurations = configurations-manager.mkDarwinConfigurations {
    specialArgs = inputs;
    homeSpecialArgs = inputs;
    extraHomeManagerArgs = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      useUserPackages = true;
    };
    hosts = {
      # Mario's MacBook Pro configuration.
      "Marios-MacBook-Pro" = {
        system = "aarch64-darwin";
        users = {
          "mariovagomarzal" = {
            userInfo = {
              email = "mariovagomarzal@gmail.com";
              githubUser = "mariovagomarzal";
            };
          };
        };
      };
    };
  };
}
