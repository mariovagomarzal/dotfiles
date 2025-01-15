#####################################
# Alicritty terminal configuration. #
#####################################
{config, ...}: {
  programs.alacritty = {
    enable = true;

    # Alacritty configuration content.
    settings = {
      # Shell configuration.
      terminal.shell = {
        program = "${config.programs.fish.package}/bin/fish";
        args = ["-l"];
      };

      # Window configuration.
      window = {
        opacity = 0.95;
        blur = true;

        dimensions = {
          columns = 120;
          lines = 40;
        };

        padding = {
          x = 6;
          y = 6;
        };
      };

      # Font configuration.
      font = {
        size = 12.5;

        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };

        italic = {
          style = "Light";
        };

        bold_italic = {
          style = "Medium";
        };
      };

      # Cursor configuration.
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Always";
        };
      };
    };
  };
}
