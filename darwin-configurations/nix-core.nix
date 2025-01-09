##################################
# Nix and Nixpkgs configuration. #
##################################
{
  pkgs,
  lib,
  nur,
  nixpkgs-firefox-darwin,
  ...
}: {
  # Auto upgrade Nix and the daemon service.
  services.nix-daemon.enable = true;

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
    nixpkgs-firefox-darwin.overlay
  ];
}
