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
    // {inherit hostName system userName userEmail;};
in {
  "${hostName}" = inputs.nix-darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules = [
      # Module for the Nix configuration itself.
      ./modules/nix-core.nix

      # Module for the host and users configuration.
      ./modules/host-users.nix
    ];
  };
}
