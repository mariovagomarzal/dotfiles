#####################################
# Alicritty terminal configuration. #
#####################################
{pkgs, ...}: {
  # Symlink the "alacritty-theme" repository.
  home.file.alacritty-theme = {
    source = pkgs.fetchFromGitHub {
      owner = "alacritty";
      repo = "alacritty-theme";
      rev = "c2369cd";
      sha256 = "eCJ9CpKoBTaA684vDJ6p8IB2AhvIBfrrKuyoKCr1BJs=";
    };
    target = ".config/alacritty/alacritty-theme";
    recursive = true;
  };

  programs.alacritty = {
    enable = true;

    # Alacritty configuration content.
    settings = {
      # External imports.
      import = [
        # Set the theme to "Dracula".
        "~/.config/alacritty/alacritty-theme/themes/dracula.toml"
      ];

      # Shell configuration.
      shell = {
        program = "/run/current-system/sw/bin/fish";
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
