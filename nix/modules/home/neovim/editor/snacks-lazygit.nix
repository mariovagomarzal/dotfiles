_: {
  programs.nixvim = {
    plugins.snacks.settings.lazygit = {
      configure = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>lua Snacks.lazygit()<CR>";
        options.desc = "Open lazygit";
      }
    ];
  };
}
