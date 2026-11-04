# workaround: home-manager has no module for the Herdr desktop app, so a
# minimal `programs.herdr-app` is declared here, shaped like its other program
# modules. Remove when it has one, moving the settings in `default.nix` and the
# theme in `catppuccin.nix` to its options
# (https://github.com/nix-community/home-manager/tree/master/modules/programs).
#
# The app saves its zoom and the changes made in its settings screen to
# `settings.json`, so the file stays writable and the declared settings are
# merged into it on every activation.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.herdr-app;
  json = pkgs.formats.json {};
in {
  options.programs.herdr-app = {
    enable = lib.mkEnableOption "the Herdr desktop app";

    package = lib.mkPackageOption pkgs "herdr-desktop" {nullable = true;};

    settings = lib.mkOption {
      inherit (json) type;
      default = {};
      example = {
        font = "Fira Code";
        font_size = 12;
      };
      description = ''
        Settings merged into {file}`$XDG_CONFIG_HOME/herdr-app/settings.json`
        on activation; those declared here win over the ones saved by the app.
      '';
    };

    themes = lib.mkOption {
      type = lib.types.attrsOf json.type;
      default = {};
      description = ''
        Themes written to {file}`$XDG_CONFIG_HOME/herdr-app/themes/<name>.json`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [cfg.package];

    home.activation.herdrAppSettings = lib.hm.dag.entryAfter ["linkGeneration"] (
      lib.hm.generators.mkImpureConfigMerger {
        inherit pkgs;
        format = "json";
        empty = "{}";
        jqOperation = "$dynamic * $static";
        path = "${config.xdg.configHome}/herdr-app/settings.json";
        staticSettings = json.generate "herdr-app-settings.json" cfg.settings;
      }
    );

    xdg.configFile = lib.mapAttrs' (name: theme:
      lib.nameValuePair "herdr-app/themes/${name}.json" {
        source = json.generate "herdr-app-theme-${name}.json" theme;
      })
    cfg.themes;
  };
}
