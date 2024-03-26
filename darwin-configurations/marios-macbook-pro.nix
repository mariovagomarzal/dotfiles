######################################
# Mario's MacBook Pro configuration. #
######################################
{inputs, ...}: let
  hostName = "Marios-MacBook-Pro";
  system = "aarch64-darwin";
  userName = "mariovagomarzal";
  userEmail = "mariovagomarzal@gmail.com";
  specialArgs =
    inputs
    // {inherit hostName userName userEmail;};
in {
  "${hostName}" = inputs.nix-darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules = [
      # Module for the Nix configuration itself.
      ./modules/nix-core.nix

      # Module for the host and users configuration.
      ./modules/host-users.nix

      # Module with the system configuration.
      ./modules/system.nix

      # Module with the packages to install and manage.
      ./modules/packages.nix

      # Home Manager module.
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.backupFileExtension = "backup";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${userName} = import ./home;
      }
    ];
  };
}
