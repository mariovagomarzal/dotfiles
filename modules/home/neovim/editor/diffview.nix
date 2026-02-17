#######################################
# Neovim Diffview plugin submodule. #
#######################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Diffview.
      diffview = {
        enable = true;
      };
    };

    # Diffview keymaps.
    keymaps = [
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen<CR>";
        options = {
          desc = "Open diff view";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gh";
        action = "<cmd>DiffviewFileHistory<CR>";
        options = {
          desc = "Open file history";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>DiffviewClose<CR>";
        options = {
          desc = "Close diff view";
          silent = true;
        };
      }
    ];
  };
}
