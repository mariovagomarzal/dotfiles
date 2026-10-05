{config, ...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      terminal.shell = {
        program = "${config.programs.fish.package}/bin/fish";
        args = ["-l"];
      };

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
