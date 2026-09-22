######################################
# Neovim dashboard plugin submodule. #
######################################
{lib, ...}: {
  programs.nixvim = {
    # Dashboard.
    plugins.snacks.settings.dashboard = {
      enabled = true;

      preset = {
        # Dashboard header string.
        header = let
          header_strings = [
            "        ▒█▒              █                   ░▓   ██████         ███████   █   "
            "        ███            ░██                  █░      ██  █       ▒██  ▓      █░ "
            "        ███           ███▓                 ▒█       █ █  █     ░█ █  ▓       █ "
            "       █ ░█▓        ▒█ ██                  █        █ ░█ ▒▒    █  █  ▓       ██"
            "       █  ██       █░  ██                 ░█        █  ▒░ █   █   █  ▓        █"
            "      █   ▒██    ██    ██                 ▓█        █   █  █ █▒   █  ▓        █"
            "     ▒░    ██  ░█     ░██                 ▓█        █    █  ██    █  ▓        █"
            "     █      ███▒      ▒█▓     █▓    █▓     █        █     █ █     █  ▓       ░█"
            "░█▒▓█       ░█        ▒██    ▓  █    ▒     █       ███    ░█     █░  █░      █▓"
            "░██▒                   ▒░      █▒   █      ░█                                █ "
            "                               █▒  █        ░█                              █  "
            "                                 █░           █                           ░█   "
          ];
        in
          builtins.concatStringsSep "\n" header_strings;

        # Key actions to show in the keys section.
        keys = [
          {
            icon = " ";
            key = "f";
            desc = "Find file";
            action = ":lua Snacks.dashboard.pick('files')";
          }
          {
            icon = " ";
            key = "g";
            desc = "Find text";
            action = ":lua Snacks.dashboard.pick('live_grep')";
          }
          {
            icon = " ";
            key = "n";
            desc = "New file";
            action = ":ene";
          }
          {
            icon = " ";
            key = "d";
            desc = "Dotfiles";
            action.__raw = ''
              function()
                local dotfiles_path = os.getenv("HOME") .. "/Projects/dotfiles"
                vim.cmd("cd " .. dotfiles_path)
                Snacks.dashboard.pick('files')
              end
            '';
          }
          # TODO: Add a key for recovering the last session.
          {
            icon = " ";
            key = "q";
            desc = "Quit";
            action = ":qa";
          }
        ];
      };

      sections = let
        # Horizontal centered line item.
        h_line = {
          text = {
            __unkeyed = lib.strings.replicate 40 "─";
            hl = "NonText";
            align = "center";
          };
          padding = 1;
        };

        # Lua function to check if current directory is a git repository.
        is_git_project = enable: let
          comparision =
            if enable
            then "~="
            else "==";
        in ''
          function()
            return Snacks.git.get_root() ${comparision} nil
          end
        '';
      in [
        # Header and keys sections.
        {
          section = "header";
          padding = 3;
        }
        {
          section = "keys";
          gap = 1;
          padding = 1;
        }
        h_line

        # Projects and recent files sections.
        {
          enabled.__raw = is_git_project false;
          icon = " ";
          title = "Projects";
          section = "projects";
          indent = 2;
          padding = 1;
        }
        {
          enabled.__raw = is_git_project false;
          icon = " ";
          title = "Recent files";
          section = "recent_files";
          indent = 2;
          padding = 1;
        }

        # Git project sections.
        {
          enabled.__raw = is_git_project true;
          icon = " ";
          desc = "Open file explorer";
          padding = 1;
          key = "e";
          action = ":lua Snacks.explorer()";
        }
        {
          enabled.__raw = is_git_project true;
          icon = " ";
          desc = "Browse repository";
          padding = 1;
          key = "b";
          action = ":lua Snacks.gitbrowse()";
        }
        {
          enabled.__raw = is_git_project true;
          icon = " ";
          title = "Git status";
          section = "terminal";
          cmd = "git status --short --branch";
          height = 5;
          indent = 2;
          padding = 1;
        }

        # Footer.
        {
          text = {
            __unkeyed.__raw = ''
              string.format(
                "Neovim %d.%d.%d • %s",
                vim.version().major,
                vim.version().minor,
                vim.version().patch,
                os.date("%m/%d/%Y")
              )
            '';
            hl = "SnacksDashboardFooter";
            align = "center";
          };
          padding = 3;
        }
      ];
    };
  };
}
