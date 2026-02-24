#######################################
# Neovim Toggleterm plugin submodule. #
#######################################
{...}: {
  programs.nixvim = {
    # Toggleterm.
    plugins.toggleterm = {
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
        direction = "horizontal";

        # Ensure horizontal terminals span the full width.
        on_open.__raw = ''
          function(term)
            if term.direction == "horizontal" then
              vim.cmd("wincmd J")
            end
          end
        '';

        # Float options.
        float_opts = {
          border = "rounded";
        };
      };
    };

    # Lua helpers for terminal session management.
    extraConfigLua = ''
      local function in_terminal()
        return vim.bo.filetype == "toggleterm"
      end

      local function direction_of(id)
        local term = require("toggleterm.terminal").get(id)
        return term and term.direction or "float"
      end

      local function close()
        vim.cmd("ToggleTerm")
      end

      local function open(n, direction)
        if direction then
          vim.cmd(n .. "ToggleTerm direction=" .. direction)
        else
          vim.cmd(n .. "ToggleTerm")
        end
      end

      _G._toggleterm_last = 1

      function _G._toggleterm_switch(n)
        local prev = _G._toggleterm_last
        _G._toggleterm_last = n
        if in_terminal() then
          if vim.b.toggle_number == n then
            close()
          else
            local dir = direction_of(vim.b.toggle_number)
            close()
            open(n, dir)
          end
        else
          local prev_term = require("toggleterm.terminal").get(prev)
          local dir = prev_term and prev_term.direction or "float"
          if prev_term then
            prev_term:close()
          end
          open(n, dir)
        end
      end

      function _G._toggleterm_toggle(direction)
        local n = _G._toggleterm_last
        if in_terminal() then
          if not direction or direction == direction_of(vim.b.toggle_number) then
            close()
          else
            close()
            open(n, direction)
          end
        else
          open(n, direction)
        end
      end
    '';

    # Toggleterm keymaps.
    keymaps = let
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
    in
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
