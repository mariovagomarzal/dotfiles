#################################
# Configuration for Nix itself. #
#################################
{
  pkgs,
  lib,
  ...
}: {
  nix.package = pkgs.nix;

  # Auto upgrade Nix and the daemon service.
  services.nix-daemon.enable = true;

  # Enable the "nix-command" and "flakes" experimental features.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable the Nix garbage collector. It will run automatically every week
  # to keep disk usage in check.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  # Allow unfree packages from the Nixpkgs repository.
  nixpkgs.config.allowUnfree = true;

  # Disable "auto-optimise-store" because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  nix.settings = {
    auto-optimise-store = false;
  };
}
