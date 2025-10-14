#########################
# Starship home module. #
#########################
{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    # Starship configuration content.
    settings = {
      format = lib.concatStrings [
        "[](fg:mauve)"
        "$os"
        "$username"
        "[](bg:maroon fg:prev_bg)"
        "$directory"
        "[](bg:peach fg:prev_bg)"
        "$git_branch"
        "$git_status"
        "[](bg:yellow fg:prev_bg)"
        "$python"
        "$julia"
        "$typst"
        "[](bg:blue fg:prev_bg)"
        "$cmd_duration"
        "$character "
      ];

      # OS module.
      os = {
        format = "[ $symbol]($style)";
        style = "bg:mauve fg:base";
        disabled = false;
        symbols = {
          Macos = "";
          NixOS = "";
        };
      };

      # Username module.
      username = {
        format = "[ $user ]($style)";
        style_root = "bg:mauve fg:base";
        style_user = "bg:mauve fg:base";
        show_always = true;
      };

      # Directory module.
      directory = {
        format = "[( $read_only)]($read_only_style)[ $path ]($style)";
        style = "bg:prev_bg fg:base";
        truncation_symbol = "…/";
        read_only = " ";
        read_only_style = "bg:prev_bg fg:base";
        home_symbol = " ";
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
        style = "bg:prev_bg fg:base";
        symbol = "";
      };

      git_status = {
        format = "[ $all_status$ahead_behind ]($style)";
        style = "bg:prev_bg fg:base";
      };

      # Python module (custom).
      python = {
        format = "[ $symbol $version( \\($virtualenv\\)) ]($style)";
        style = "bg:prev_bg fg:base";
        symbol = "";
        version_format = "v\${raw}";
      };

      # Julia module.
      julia = {
        format = "[ $symbol $version ]($style)";
        version_format = "\${raw}";
        style = "bg:prev_bg fg:base";
        symbol = "";
      };

      # Typst module.
      typst = {
        format = "[ $symbol $version ]($style)";
        version_format = "\${raw}";
        style = "bg:prev_bg fg:base";
        symbol = "t";
      };

      # Command duration module.
      cmd_duration = {
        format = "[  $duration ]($style)";
        style = "bg:blue fg:base";
        min_time = 1000; # 1 second
      };

      # Character module.
      character = {
        format = "$symbol";
        success_symbol = "[](fg:prev_bg bg:green)[](fg:prev_bg)";
        error_symbol = "[](fg:prev_bg bg:red)[](fg:prev_bg)";
      };
    };
  };
}
