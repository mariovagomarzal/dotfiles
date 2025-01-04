######################################
# System configurations definitions. #
######################################
inputs @ {
  nixpkgs,
  nix-darwin,
  home-manager,
  catppuccin,
  ...
}: let
  # The custom 'configurations-manager' library.
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
  # Configurations for Darwin systems.
  darwinConfigurations = configurations-manager.mkDarwinConfigurations {
    specialArgs = inputs // {computerName = "Mario's MacBook Pro";};
    homeSpecialArgs = inputs;
    extraHomeSharedModules = [
      catppuccin.homeManagerModules.catppuccin
    ];
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
              userName = "Mario Vago Marzal";
              email = "mariovagomarzal@gmail.com";
              githubUser = "mariovagomarzal";
            };
          };
        };
      };
    };
  };
}
