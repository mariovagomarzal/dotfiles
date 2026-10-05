/**
Starship prompt with a powerline layout in Catppuccin colors, showing the OS,
user, directory, Git status, language versions and command duration.
*/
{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

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

      os = {
        format = "[ $symbol]($style)";
        style = "bg:mauve fg:base";
        disabled = false;
        symbols = {
          Macos = "";
          NixOS = "";
        };
      };

      username = {
        format = "[ $user ]($style)";
        style_root = "bg:mauve fg:base";
        style_user = "bg:mauve fg:base";
        show_always = true;
      };

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

      git_branch = {
        format = "[ $symbol $branch(:$remote_branch)]($style)";
        style = "bg:prev_bg fg:base";
        symbol = "";
      };

      git_status = {
        format = "[ $all_status$ahead_behind ]($style)";
        style = "bg:prev_bg fg:base";
      };

      python = {
        format = "[ $symbol $version( \\($virtualenv\\)) ]($style)";
        style = "bg:prev_bg fg:base";
        symbol = "";
        version_format = "v\${raw}";
      };

      julia = {
        format = "[ $symbol $version ]($style)";
        version_format = "\${raw}";
        style = "bg:prev_bg fg:base";
        symbol = "";
      };

      typst = {
        format = "[ $symbol $version ]($style)";
        version_format = "\${raw}";
        style = "bg:prev_bg fg:base";
        symbol = "t";
      };

      cmd_duration = {
        format = "[  $duration ]($style)";
        style = "bg:blue fg:base";
        min_time = 1000; # 1 second
      };

      character = {
        format = "$symbol";
        success_symbol = "[](fg:prev_bg bg:green)[](fg:prev_bg)";
        error_symbol = "[](fg:prev_bg bg:red)[](fg:prev_bg)";
      };
    };
  };
}
