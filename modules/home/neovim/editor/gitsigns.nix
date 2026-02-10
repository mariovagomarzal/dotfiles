#####################################
# Neovim Gitsigns plugin submodule. #
#####################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Gitsigns.
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = {text = "+";};
            change = {text = "~";};
            delete = {text = "_";};
            topdelete = {text = "‾";};
            changedelete = {text = "~";};
          };
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
            delay = 300;
          };
        };
      };
    };

    # Gitsigns keymaps.
    keymaps = [
      # Hunk navigation.
      {
        mode = "n";
        key = "[h";
        action = "<cmd>Gitsigns prev_hunk<CR>";
        options = {
          desc = "Previous git hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "]h";
        action = "<cmd>Gitsigns next_hunk<CR>";
        options = {
          desc = "Next git hunk";
          silent = true;
        };
      }

      # Hunk actions.
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options = {
          desc = "Preview git hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options = {
          desc = "Stage git hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<CR>";
        options = {
          desc = "Reset git hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gu";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options = {
          desc = "Undo stage git hunk";
          silent = true;
        };
      }
    ];
  };
}
