######################################
# Snacks bufdelete plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    # Snacks bufdelete.
    plugins.snacks.settings.bufdelete = {
      enabled = true;
    };

    # Buffer delete keymaps.
    keymaps = [
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua Snacks.bufdelete.delete()<CR>";
        options = {
          desc = "Delete current buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>lua Snacks.bufdelete.all()<CR>";
        options = {
          desc = "Delete all buffers";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>lua Snacks.bufdelete.other()<CR>";
        options = {
          desc = "Delete other buffers";
          silent = true;
        };
      }
    ];
  };
}
