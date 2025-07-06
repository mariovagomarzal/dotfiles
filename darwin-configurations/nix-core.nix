##################################
# Nix and Nixpkgs configuration. #
##################################
{
  pkgs,
  lib,
  nur,
  ...
}: {
  # Enable the Nix package manager.
  nix.enable = true;

  # Nix settings.
  nix.settings = {
    # Enable the "nix-command" and "flakes" experimental features.
    experimental-features = ["nix-command" "flakes"];

    # Manage the access to the Nix daemon.
    allowed-users = ["*"];
    trusted-users = ["root" "@admin"];
  };

  # Enable the Nix garbage collector.
  nix.gc = {
    automatic = true;
    interval = [
      {
        Hour = 15;
        Minute = 0;
        Weekday = 7;
      }
    ];
  };

  # Enable Nix store optimisation.
  nix.optimise = {
    automatic = true;
    interval = [
      {
        Hour = 15;
        Minute = 0;
        Weekday = 7;
      }
    ];
  };

  # Nixpkgs configuration.
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # Nixpkgs overlays.
  nixpkgs.overlays = [
    nur.overlays.default
  ];
}
