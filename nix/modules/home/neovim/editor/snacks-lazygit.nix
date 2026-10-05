####################################
# Snacks lazygit plugin submodule. #
####################################
_: {
  programs.nixvim = {
    # Snacks lazygit.
    plugins.snacks.settings.lazygit = {
      configure = true;
    };

    # Lazygit keymaps.
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
