{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    types
    mkIf
    mkMerge
    ;

  cfg = config.programs.aerospace;
in {
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

  config = mkIf (cfg.enable && cfg.swipeaerospace.enable) (mkMerge [
    {
      home.packages = [cfg.swipeaerospace.package];

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
