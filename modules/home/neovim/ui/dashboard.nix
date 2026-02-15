######################################
# Neovim dashboard plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Dashboard.
      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          config = {
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
            shortcut = [
              {
                desc = "󰈞 Find File";
                group = "@keyword";
                key = "f";
                action = "Telescope find_files";
              }
              {
                desc = " Recent Files";
                group = "@function";
                key = "r";
                action = "Telescope oldfiles";
              }
              {
                desc = " Live Grep";
                group = "@string";
                key = "g";
                action = "Telescope live_grep";
              }
              {
                desc = " Dotfiles";
                group = "@constant";
                key = "c";
                action = "Telescope find_files cwd=~/Projects/dotfiles";
              }
              {
                desc = "󰈆 Quit";
                group = "@comment";
                key = "q";
                action = "qa";
              }
            ];
            mru = {
              limit = 10;
            };
            project = {
              enable = true;
              limit = 5;
              action = "Telescope find_files cwd=";
            };
            packages.enable = false;
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
