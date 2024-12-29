##################################
# Nix and Nixpkgs configuration. #
##################################
{
  pkgs,
  lib,
  users,
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

  # Nixpks configuration.
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
}
