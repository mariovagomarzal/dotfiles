######################################
# Neovim dashboard plugin submodule. #
######################################
{...}: let
  # Returns a raw Lua action that changes the working directory to the given
  # Lua path expression and opens Neo-tree there.
  neotreeAction = luaPathExpr: {
    __raw = ''
      function(path)
        local target = ${luaPathExpr}
        vim.cmd("cd " .. target)
        vim.cmd("Neotree focus filesystem dir=" .. target)
      end
    '';
  };
in {
  programs.nixvim = {
    plugins = {
      # Dashboard.
      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          config = {
            # Header banner.
            header = [
              ""
              ""
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
              ""
              ""
            ];

            # Shortcuts.
            shortcut = [
              {
                desc = "󰈞 Find File";
                group = "@keyword";
                key = "f";
                action = "Telescope find_files";
              }
              {
                desc = "󰅐 Recent Files";
                group = "@function";
                key = "r";
                action = "Telescope oldfiles";
              }
              {
                desc = "󰍉 Live Grep";
                group = "@string";
                key = "g";
                action = "Telescope live_grep";
              }
              {
                desc = "󰏗 Dotfiles";
                group = "@constant";
                key = "c";
                action = neotreeAction ''vim.fn.expand("~/Projects/dotfiles")'';
              }
              {
                desc = "󰈆 Quit";
                group = "@comment";
                key = "q";
                action = "qa";
              }
            ];

            # Recent files.
            mru = {
              limit = 10;
            };

            # Projects.
            project = {
              enable = true;
              limit = 5;
              action = neotreeAction "path";
            };

            # Packages (disabled).
            packages.enable = false;

            # Footer.
            footer.__raw = ''
              function()
                local v = vim.version()
                local version = string.format("v%d.%d.%d", v.major, v.minor, v.patch)
                local date = os.date("%A, %B %d, %Y")
                return { "", "Neovim " .. version .. "  •  " .. date }
              end
            '';
          };
        };
      };
    };
  };
}
