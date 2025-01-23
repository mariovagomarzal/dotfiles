########################################
# Custom Home-Manager module for Skhd. #
########################################
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

  # Skhd service configuration object.
  cfg = config.services.skhd;
in {
  # Options for the Skhd service module.
  options = {
    services.skhd = {
      enable = mkEnableOption "skhd";

      package = mkPackageOption pkgs "skhd" {};

      configSource = mkOption {
        type = types.path;
        description = ''
          The path to the Skhd configuration file or directory.

          If the path is a directory, the whole directory will be symlinked to
          the `$XDG_CONFIG_HOME/skhd` directory.

          If the path is a file, it will be symlinked to the
          `$XDG_CONFIG_HOME/skhd/skhdrc` file. Note that the symlinked file
          won't be executable unless the provided file is executable.
        '';
        example = ''
          ./skhd-config
        '';
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = ''
          Additional packages to add to the Skhd launchd agent's PATH.
        '';
        example = ''
          [pkgs.jq]
        '';
      };

      extraEnvironment = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = ''
          Additional environment variables to add to the Skhd launchd
          agent's environment.
        '';
        example = ''
          {"CATPPUCCIN_FLAVOR" = "mocha";}
        '';
      };
    };
  };

  # Skhd service configuration.
  config = mkIf cfg.enable (mkMerge [
    {
      # Add the package to the list of packages to install.
      home.packages = [cfg.package];

      # Add the Skhd configuration directory or file.
      xdg.configFile."skhd" =
        mkIf (
          lib.pathIsDirectory cfg.configSource
        ) {
          source = cfg.configSource;
          recursive = false;
        };

      xdg.configFile."skhd/skhdrc" =
        mkIf (
          lib.pathIsRegularFile cfg.configSource
        ) {
          source = cfg.configSource;
        };

      # Add the Skhd launchd agent.
      launchd.agents."skhd" = {
        enable = true;
        config = {
          Label = "skhd";
          ProgramArguments = [
            "${cfg.package}/bin/skhd"
          ];
          WorkingDirectory = "${config.home.homeDirectory}/.config/skhd";
          EnvironmentVariables = let
            totalPackages = [cfg.package] ++ cfg.extraPackages;
          in
            {
              SHELL = "/usr/bin/env bash";
              PATH =
                "/usr/bin:/bin:/usr/sbin:"
                + (lib.concatStringsSep ":" (
                  map (pkg: "${pkg}/bin") totalPackages
                ));
            }
            // cfg.extraEnvironment;
          ProcessType = "Interactive";
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/tmp/skhd_stdout_${config.home.username}.log";
          StandardErrorPath = "/tmp/skhd_stderr_${config.home.username}.log";
        };
      };
    }
  ]);
}
