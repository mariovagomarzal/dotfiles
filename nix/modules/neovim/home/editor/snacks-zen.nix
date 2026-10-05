_: {
  programs.nixvim = {
    plugins.snacks.settings.zen = {
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>lua Snacks.zen()<CR>";
        options.desc = "Toggle zen mode";
      }
    ];
  };
}
