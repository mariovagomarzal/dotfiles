##################################
# Snacks words plugin submodule. #
##################################
{...}: {
  programs.nixvim = {
    # Snacks words.
    plugins.snacks.settings.words = {
      enabled = true;
    };

    # Words jumping keymaps.
    keymaps = [
      {
        mode = "n";
        key = "]]";
        action = "<cmd>lua Snacks.words.jump(vim.count1, true)<CR>";
        options = {
          desc = "Next reference";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "[[";
        action = "<cmd>lua Snacks.words.jump(-vim.count1, true)<CR>";
        options = {
          desc = "Previous reference";
          silent = true;
        };
      }
    ];
  };
}
