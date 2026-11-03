# workaround: catppuccin/nix has no port for the Herdr desktop app, so one is
# declared here as its ports are, with a theme built from its palette and the
# ANSI colours of its Ghostty theme. Remove when it has one
# (https://github.com/catppuccin/nix/tree/main/modules/home-manager).
{
  inputs,
  options,
  config,
  lib,
  pkgs,
  ...
}: let
  # The library catppuccin/nix builds its ports with, which it does not export.
  catppuccinLib = import "${inputs.catppuccin}/modules/lib" {inherit options config lib pkgs;};

  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.herdr-app;
  enable = config.catppuccin.enable && cfg.enable && config.programs.herdr-app.enable;

  themeName = "catppuccin-${cfg.flavor}";
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in {
  options.catppuccin.herdr-app = catppuccinLib.mkCatppuccinOption {
    name = "herdr-app";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.herdr-app = {
      settings.theme = themeName;

      themes.${themeName} = {
        background = palette.base.hex;
        foreground = palette.text.hex;
        selection = palette.surface0.hex;
        cursor = palette.rosewater.hex;
        ansi = map (name: palette.${name}.hex) [
          "surface1"
          "red"
          "green"
          "yellow"
          "blue"
          "pink"
          "teal"
          "subtext0"
          "surface2"
          "red"
          "green"
          "yellow"
          "blue"
          "pink"
          "teal"
          "subtext1"
        ];
        colors.accent = palette.${cfg.accent}.hex;
      };
    };
  };
}
