#####################################
# Neovim Neo-tree plugin submodule. #
#####################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Neo-tree.
      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = false;
          popup_border_style = "rounded";
          open_files_do_not_replace_types = ["terminal" "trouble" "qf"];
          enable_git_status = true;
          enable_diagnostics = true;
          window = {
            position = "left";
            width = 30;
          };
          filesystem = {
            follow_current_file = {
              enabled = true;
            };
            use_libuv_file_watcher = true;
            filtered_items = {
              visible = false;
              hide_dotfiles = false;
              hide_gitignored = true;
              hide_by_name = [
                ".git"
                ".DS_Store"
                "__pycache__"
              ];
            };
          };
        };
      };
    };

    # Neo-tree keymaps.
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          desc = "Toggle file explorer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>be";
        action = "<cmd>Neotree toggle source=buffers<CR>";
        options = {
          desc = "Toggle buffer explorer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ge";
        action = "<cmd>Neotree toggle source=git_status<CR>";
        options = {
          desc = "Toggle git explorer";
          silent = true;
        };
      }
    ];
  };
}
