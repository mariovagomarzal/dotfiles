_: {
  programs.nixvim = {
    plugins.snacks.settings.explorer = {
      replace_netrw = true;
      trash = true;
    };

    plugins.snacks.settings.picker.sources.explorer = {
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua Snacks.explorer()<CR>";
        options.desc = "Explorer";
      }
    ];
  };
}
