#######################################
# Neovim Toggleterm plugin submodule. #
#######################################
{...}: let
  # Generate terminal switch keymaps for <leader>t<0-9>.
  terminalSwitchKeymaps =
    builtins.genList (i: let
      n = i + 1;
      key =
        if n == 10
        then "0"
        else toString n;
    in {
      mode = "n";
      key = "<leader>t${key}";
      action = "<cmd>lua _G._toggleterm_switch(${toString n})<CR>";
      options = {
        desc = "Switch to terminal ${toString n}";
        silent = true;
      };
    })
    10;
in {
  programs.nixvim = {
    plugins = {
      # Toggleterm.
      toggleterm = {
        enable = true;

        settings = {
          # General settings.
          hide_numbers = true;
          start_in_insert = false;
          close_on_exit = true;
          auto_scroll = true;

          # Size for non-float directions.
          size.__raw = ''
            function(term)
              if term.direction == "vertical" then
                return math.floor(vim.o.columns * 0.4)
              else
                return math.floor(vim.o.lines * 0.3)
              end
            end
          '';

          # Default direction.
          direction = "float";

          # Float options.
          float_opts = {
            border = "rounded";
          };
        };
      };
    };

    # Lua helpers for terminal session management.
    extraConfigLua = ''
      _G._toggleterm_last = 1

      function _G._toggleterm_switch(n)
        _G._toggleterm_last = n
        if vim.bo.filetype == "toggleterm" then
          local current = vim.b.toggle_number
          if current == n then
            vim.cmd("ToggleTerm")
            return
          end
          local terms = require("toggleterm.terminal")
          local term = terms.get(current)
          local direction = term and term.direction or "float"
          vim.cmd("ToggleTerm")
          vim.cmd(n .. "ToggleTerm direction=" .. direction)
        else
          vim.cmd(n .. "ToggleTerm direction=float")
        end
      end

      function _G._toggleterm_toggle(direction)
        local n = _G._toggleterm_last
        if vim.bo.filetype == "toggleterm" then
          local terms = require("toggleterm.terminal")
          local term = terms.get(vim.b.toggle_number)
          local current_dir = term and term.direction or "float"
          if not direction or direction == current_dir then
            vim.cmd("ToggleTerm")
          else
            vim.cmd("ToggleTerm")
            vim.cmd(n .. "ToggleTerm direction=" .. direction)
          end
        elseif direction then
          vim.cmd(n .. "ToggleTerm direction=" .. direction)
        else
          vim.cmd(n .. "ToggleTerm")
        end
      end
    '';

    # Toggleterm keymaps.
    keymaps =
      [
        # Terminal toggles (uses last used terminal).
        {
          mode = "n";
          key = "<leader>tt";
          action = "<cmd>lua _G._toggleterm_toggle()<CR>";
          options = {
            desc = "Toggle terminal";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>tf";
          action = "<cmd>lua _G._toggleterm_toggle('float')<CR>";
          options = {
            desc = "Toggle float terminal";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>th";
          action = "<cmd>lua _G._toggleterm_toggle('horizontal')<CR>";
          options = {
            desc = "Toggle horizontal terminal";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>tv";
          action = "<cmd>lua _G._toggleterm_toggle('vertical')<CR>";
          options = {
            desc = "Toggle vertical terminal";
            silent = true;
          };
        }

        # Terminal mode escape.
        {
          mode = "t";
          key = "<esc><esc>";
          action = "<C-\\><C-n>";
          options = {
            desc = "Exit terminal mode";
            silent = true;
          };
        }
      ]
      ++ terminalSwitchKeymaps;
  };
}
