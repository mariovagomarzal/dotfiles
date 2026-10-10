/**
Alacritty terminal with FiraCode Nerd Font and a translucent, blurred window.
*/
_: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        option_as_alt = "OnlyLeft";
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

      cursor = {
        style = {
          shape = "Beam";
          blinking = "Always";
        };
      };
    };
  };
}
