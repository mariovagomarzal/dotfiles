####################################
# Nix core settings shared module. #
####################################
{inputs, ...}: {
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

  # Nixpkgs configuration.
  # NOTE: This configuration should be inherited from the Blueprint
  # configuration of Nixpkgs, set in the `flake.nix` file. However, due to an
  # unknow issue, 'Darwin' and 'NixOS' systems do not inherit this. For more
  # details, see:
  #   https://github.com/numtide/blueprint/issues/115
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Nixpkgs overlays.
  # NOTE: Same as above.
  nixpkgs.overlays = with inputs; [
    nur.overlays.default
    nixpkgs-firefox-darwin.overlay
  ];
}
