################################################
# Custom Home-Manager module for JankyBorders. #
################################################
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

  # JankyBorders service configuration object.
  cfg = config.services.jankyborders;
in {
  # Options for the JankyBorders service module.
  options = {
    services.jankyborders = {
      enable = mkEnableOption "jankyborders";

      package = mkPackageOption pkgs "jankyborders" {};

      settings = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = ''
          The settings for JankyBorders. It will be passed to the JankyBorders
          launchd agent as arguments with the `key=value` format.
        '';
        example = ''
          {
            "width" = "4.0";
            "active_color" = "0xff8839ef";
            "inactive_color" = "0xffbcc0cc";
          }
        '';
      };
    };
  };

  # JankyBorders service configuration.
  config = mkIf cfg.enable (mkMerge [
    {
      # Add the package to the list of packages to install.
      home.packages = [cfg.package];

      # Add the JankyBorders launchd agent.
      launchd.agents."jankyborders" = {
        enable = true;
        config = {
          Label = "jankyborders";
          ProgramArguments = let
            # Convert the settings to a list of arguments.
            settings =
              lib.mapAttrsToList (
                key: value: "${key}=${value}"
              )
              cfg.settings;
          in
            [
              "${cfg.package}/bin/borders"
            ]
            ++ settings;
          ProcessType = "Interactive";
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/tmp/borders_stdout_${config.home.username}.log";
          StandardErrorPath = "/tmp/borders_stderr_${config.home.username}.log";
        };
      };
    }
  ]);
}
