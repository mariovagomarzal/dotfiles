########################################
# Mario's PC (Marios-PC) NixOS system. #
########################################
{flake, ...}: let
  inherit
    (flake.lib.modules)
    modulesWithout
    ;
in {
  system.stateVersion = "25.05";

  # Host information.
  networking.hostName = "Marios-PC";

  # Users information.
  users.users = {
    "mariovagomarzal" = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      description = "Mario Vago Marzal";
    };
  };

  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ modulesWithout {
      "nixos" = [];
      "shared" = [];
    };
}
