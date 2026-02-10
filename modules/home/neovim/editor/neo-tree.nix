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
    ];
  };
}
