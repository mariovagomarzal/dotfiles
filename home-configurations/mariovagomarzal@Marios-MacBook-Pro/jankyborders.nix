#############################################
# JankyBorders configuration for this user. #
#############################################
{
  pkgs,
  config,
  ...
}: let
  # JankyBorders package to use.
  jankyborders = pkgs.jankyborders;

  # Catppuccin palettes.
  palettes = {
    latte = {
      mauve = "0xff8839ef";
      surface0 = "0xffbcc0cc";
    };
    frappe = {
      mauve = "0xffca9ee6";
      surface0 = "0xff414559";
    };
    macchiato = {
      mauve = "0xffc6a0f6";
      surface0 = "0xff363a4f";
    };
    mocha = {
      mauve = "0xffcba6f7";
      surface0 = "0xff313244";
    };
  };
  palette = palettes.${config.catppuccin.flavor};
in {
  home.packages = [jankyborders];

  # Add JankyBorders to the user's launchd agents.
  launchd.agents.jankyborders = {
    enable = true;
    config = {
      Label = "jankyborders";
      ProgramArguments = [
        "${jankyborders}/bin/borders"
        "style=round"
        "width=4.0"
        "hidpi=off"
        "active_color=${palette.mauve}"
        "inactive_color=${palette.surface0}"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };
}
