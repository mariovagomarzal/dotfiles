#################################
# Custom AeroSpace home module. #
#################################
{
  config,
  lib,
  pkgs,
  ...
}: let
  # Options related functions.
  inherit
    (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    types
    mkIf
    mkMerge
    ;

  # AeroSpace program configuration object.
  cfg = config.programs.aerospace;
in {
  # Extended options for the AeroSpace program module.
  options = {
    programs.aerospace.swipeaerospace = {
      enable = mkEnableOption "swipeaerospace";

      package = mkPackageOption pkgs.dotfiles "swipeaerospace" {};

      keepAlive = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether the launchd service for SwipeAeroSpace should be kept alive.
        '';
      };
    };
  };

  # Extended AeroSpace program configuration.
  config = mkIf (cfg.enable && cfg.swipeaerospace.enable) (mkMerge [
    {
      # Add the SwipeAeroSpace package to the list of packages to install.
      home.packages = [cfg.swipeaerospace.package];

      # Configure the launchd service for SwipeAeroSpace.
      launchd.agents.swipeaerospace = {
        enable = true;
        config = {
          Program =
            "${cfg.swipeaerospace.package}"
            + "/Applications/SwipeAeroSpace.app/Contents/MacOS/SwipeAeroSpace";
          KeepAlive = cfg.swipeaerospace.keepAlive;
          RunAtLoad = true;
          StandardOutPath = "/tmp/swipeaerospace.log";
          StandardErrorPath = "/tmp/swipeaerospace.log";
        };
      };
    }
  ]);
}
