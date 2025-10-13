####################################
# Nix core settings Darwin module. #
####################################
{
  pkgs,
  lib,
  inputs,
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
}
