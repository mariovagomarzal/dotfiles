#############################################
# JankyBorders configuration for this user. #
#############################################
{
  lib,
  config,
  ...
}: let
  # Catppuccin configuration.
  catppuccin = config.catppuccin;

  # Import the Catppuccin palette based on the user's flavor.
  palette =
    (
      lib.importJSON "${catppuccin.sources.palette}/palette.json"
    )
    .${catppuccin.flavor}
    .colors;

  # Function to generate a color with '0xaarrggbb' format.
  colorWithAlpha = color: alpha: let
    hex = lib.removePrefix "#" palette.${color}.hex;
  in "0x${alpha}${hex}";
in {
  services.jankyborders = {
    enable = true;

    # JankyBorders configuration content.
    settings = {
      "width" = "4.0";
      "active_color" = colorWithAlpha catppuccin.accent "ff";
      "inactive_color" = colorWithAlpha "surface0" "ff";
      "style" = "round";
      "hidpi" = "off";
    };
  };
}
