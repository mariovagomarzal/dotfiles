##################################
# Starship prompt configuration. #
##################################
{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    # Starship configuration content.
    settings = {
      format = lib.concatStrings [
        "[](color1)"
        "$os"
        "$username"
        "[](bg:color2 fg:color1)"
        "$directory"
        "[](fg:color2 bg:color3)"
        "$git_branch"
        "$git_status"
        "[](fg:color3 bg:color4)"
        "\${custom.python}"
        "$julia"
        "$typst"
        "[](fg:color4 bg:color5)"
        "$cmd_duration"
        "$character "
      ];

      # Custom color palettes.
      palettes = {
        "amethyst" = {
          "color1" = "#653B9A";
          "color2" = "#8B70B5";
          "color3" = "#AB9AC6";
          "color4" = "#D8CEEF";
          "color5" = "#F6F5F2";
          "success_green" = "#6B8E23";
          "error_red" = "#8B0000";
        };
        "oak" = {
          color1 = "#1F1815";
          color2 = "#52463E";
          color3 = "#635654";
          color4 = "#A58A73";
          color5 = "#C2B1A1";
          success_green = "#556B2F";
          error_red = "#A52A2A";
        };
        "pastel" = {
          color1 = "#BD0370";
          color2 = "#D84595";
          color3 = "#EE90BA";
          color4 = "#F0C8D4";
          color5 = "#F3F3F5";
          success_green = "#98FB98";
          error_red = "#DC143C";
        };
        "snow" = {
          color1 = "#0054AA";
          color2 = "#1672B6";
          color3 = "#288CEF";
          color4 = "#A4D1FC";
          color5 = "#D0E9FF";
          success_green = "#008000";
          error_red = "#8B0000";
        };
      };

      # Set the palette to use.
      palette = "amethyst";

      # OS module.
      os = {
        format = "[ $symbol]($style)";
        style = "bg:color1";
        disabled = false;
        symbols.Macos = "";
      };

      # Username module.
      username = {
        format = "[ $user ]($style)";
        style_root = "bg:color1";
        style_user = "bg:color1";
        show_always = true;
      };

      # Directory module.
      directory = {
        format = "[$read_only]($read_only_style)[ $path ]($style)";
        style = "bg:color2 fg:black";
        truncation_symbol = "…/";
        read_only = " ";
        read_only_style = "bg:color2 fg:black";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Desktop" = " ";
          "Music" = " ";
          "Library" = "󱉟 ";
          "Development" = " ";
          "Projects" = " ";
          "Applications" = " ";
        };
      };

      # Git modules.
      git_branch = {
        format = "[ $symbol $branch(:$remote_branch)]($style)";
        style = "bg:color3 fg:black";
        symbol = "";
      };

      git_status = {
        format = "[ $all_status$ahead_behind ]($style)";
        style = "bg:color3 fg:black";
      };

      # Python module (custom).
      custom.python = {
        description = "Python version";
        format = "[ $symbol $output ]($style)";
        style = "bg:color4 fg:black";
        symbol = "";
        shell = "fish";
        when = "_is_python_project";
        command = "_python_info";
        ignore_timeout = true;
      };

      # Julia module.
      julia = {
        format = "[ $symbol $version ]($style)";
        version_format = "\${raw}";
        style = "bg:color4 fg:black";
        symbol = "";
      };

      # Typst module.
      typst = {
        format = "[ $symbol $version ]($style)";
        version_format = "\${raw}";
        style = "bg:color4 fg:black";
        symbol = "t";
      };

      # Command duration module.
      cmd_duration = {
        format = "[  $duration ]($style)";
        style = "bg:color5 fg:black";
        min_time = 1000; # 1 second
      };

      # Character module.
      character = {
        format = "$symbol";
        success_symbol = "[](fg:color5 bg:success_green)[](fg:success_green)";
        error_symbol = "[](fg:color5 bg:error_red)[](fg:error_red)";
      };
    };
  };
}
