###########################################
# Neovim Toggleterm plugin submodule.     #
###########################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Toggleterm.
      toggleterm = {
        enable = true;
        settings = {
          # General settings.
          hide_numbers = true;
          start_in_insert = true;
          close_on_exit = true;
          auto_scroll = true;

          # Size for non-float directions.
          size = 15;

          # Default direction.
          direction = "float";

          # Float options.
          float_opts = {
            border = "rounded";
          };
        };
      };
    };

    # Toggleterm keymaps.
    keymaps = [
      # Terminal toggles.
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>ToggleTerm<CR>";
        options = {
          desc = "Toggle terminal";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>ToggleTerm direction=float<CR>";
        options = {
          desc = "Toggle float terminal";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<CR>";
        options = {
          desc = "Toggle horizontal terminal";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical<CR>";
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
    ];
  };
}
