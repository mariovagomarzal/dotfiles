_: {
  programs.nixvim = {
    plugins.snacks.settings.words = {
      enabled = true;
    };

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
