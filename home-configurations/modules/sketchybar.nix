##############################################
# Custom Home-Manager module for Sketchybar. #
##############################################
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

  # Sketchybar service configuration object.
  cfg = config.services.sketchybar;
in {
  # Options for the Sketchybar service module.
  options = {
    services.sketchybar = {
      enable = mkEnableOption "sketchybar";

      package = mkPackageOption pkgs "sketchybar" {};

      configSource = mkOption {
        type = types.path;
        description = ''
          The path to the Sketchybar configuration file or directory.

          The whole directory will be symlinked to the
          `$XDG_CONFIG_HOME/sketchybar` directory.

          This option should point to a directory and not a file, since
          Sketchybar will not be able to discover the `sketchybarrc` file if
          it is a symlink. For that reason, the configuration directory is not
          symlinked recursively. For more details, see the following issue:
            https://github.com/FelixKratz/SketchyBar/issues/553
        '';
        example = ''
          ./config
        '';
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = ''
          Additional packages to add to the Sketchybar launchd agent's PATH.
        '';
        example = ''
          [pkgs.jq]
        '';
      };

      extraEnvironment = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = ''
          Additional environment variables to add to the Sketchybar launchd
          agent's environment.
        '';
        example = ''
          {"CATPPUCCIN_FLAVOR" = "mocha";}
        '';
      };
    };
  };

  # Sketchybar service configuration.
  config = mkIf cfg.enable (mkMerge [
    {
      # Add the package to the list of packages to install.
      home.packages = [cfg.package];

      # Add the Sketchybar configuration directory.
      xdg.configFile."sketchybar" = {
        source = cfg.configSource;
        recursive = false;
      };

      # Add the Sketchybar launchd agent.
      launchd.agents."sketchybar" = {
        enable = true;
        config = let
          username = config.home.username;
        in {
          Label = "sketchybar";
          ProgramArguments = [
            "${cfg.package}/bin/sketchybar"
          ];
          EnvironmentVariables = let
            totalPackages = [cfg.package] ++ cfg.extraPackages;
          in
            {
              PATH =
                (lib.concatStringsSep ":" (
                  map (pkg: "${pkg}/bin") totalPackages
                ))
                + ":/usr/bin:/bin:/usr/sbin";
            }
            // cfg.extraEnvironment;
          ProcessType = "Interactive";
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/tmp/sketchybar_stdout_${username}.log";
          StandardErrorPath = "/tmp/sketchybar_stderr_${username}.log";
        };
      };
    }
  ]);
}
