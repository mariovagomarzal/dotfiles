#########################################
# Custom Home-Manager module for Yabai. #
#########################################
{
  config,
  lib,
  pkgs,
  darwinConfig ? {},
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

  # Yabai window manager service configuration object.
  cfg = config.services.yabai;
in {
  # Options for the Yabai service module.
  options = {
    services.yabai = {
      enable = mkEnableOption "yabai";

      package = mkPackageOption pkgs "yabai" {
        extraDescription = ''
          If Home-Manager is used as a nix-darwin module and the
          `yabaiScriptingAddition.enable` option from the nix-darwin config
          is set to true, then the package defined in
          `yabaiScriptingAddition.package` will be used instead.
        '';
      };

      configSource = mkOption {
        type = types.path;
        description = ''
          The path to the Yabai configuration file or directory.

          If the path is a directory, the whole directory will be symlinked to
          the `$XDG_CONFIG_HOME/yabai` directory.

          If the path is a file, it will be symlinked to the
          `$XDG_CONFIG_HOME/yabai/yabairc` file. Note that the symlinked file
          won't be executable unless the provided file is executable.
        '';
        example = ''
          ./yabai-config
        '';
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = ''
          Additional packages to add to the Yabai launchd agent's PATH.
        '';
        example = ''
          [pkgs.jq]
        '';
      };

      extraEnvironment = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = ''
          Additional environment variables to add to the Yabai launchd
          agent's environment.
        '';
        example = ''
          {"CATPPUCCIN_FLAVOR" = "mocha";}
        '';
      };
    };
  };

  # Yabai service configuration.
  config = mkIf cfg.enable (mkMerge [
    {
      # Use the `darwinConfig.yabaiScriptingAddition.package` if the option is
      # present and enabled.
      services.yabai.package =
        mkIf (
          darwinConfig
          ? yabaiScriptingAddition.enable
          && darwinConfig.yabaiScriptingAddition.enable
        )
        darwinConfig.yabaiScriptingAddition.package;

      # Add the package to the list of packages to install.
      home.packages = [cfg.package];

      # Add the Yabai configuration directory or file.
      xdg.configFile."yabai" =
        mkIf (
          lib.pathIsDirectory cfg.configSource
        ) {
          source = cfg.configSource;
          recursive = false;
        };

      xdg.configFile."yabai/yabairc" =
        mkIf (
          lib.pathIsRegularFile cfg.configSource
        ) {
          source = cfg.configSource;
        };

      # Add the Yabai launchd agent.
      launchd.agents."yabai" = {
        enable = true;
        config = {
          Label = "yabai";
          ProgramArguments = [
            "${cfg.package}/bin/yabai"
          ];
          EnvironmentVariables = let
            totalPackages = [cfg.package] ++ cfg.extraPackages;
          in
            {
              PATH =
                "/usr/bin:/bin:/usr/sbin:"
                + (lib.concatStringsSep ":" (
                  map (pkg: "${pkg}/bin") totalPackages
                ));
            }
            // cfg.extraEnvironment;
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/tmp/yabai_stdout_${config.home.username}.log";
          StandardErrorPath = "/tmp/yabai_stderr_${config.home.username}.log";
        };
      };
    }
  ]);
}
