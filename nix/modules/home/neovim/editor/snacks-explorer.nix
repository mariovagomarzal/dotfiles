#####################################
# Snacks explorer plugin submodule. #
#####################################
_: {
  programs.nixvim = {
    # Snacks explorer.
    plugins.snacks.settings.explorer = {
      replace_netrw = true;
      trash = true;
    };

    # Explorer picker settings.
    plugins.snacks.settings.picker.sources.explorer = {
    };

    # Explorer keymaps.
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
