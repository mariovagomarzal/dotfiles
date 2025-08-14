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
    .${
      catppuccin.flavor
    }
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
      "width" = "3.0";
      "order" = "above";
      "style" = "round";
      "hidpi" = "off";
      "active_color" = colorWithAlpha "lavender" "ff";
      "inactive_color" = colorWithAlpha "overlay0" "ff";
    };
  };
}
