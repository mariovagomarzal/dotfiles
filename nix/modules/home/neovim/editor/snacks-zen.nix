################################
# Snacks zen plugin submodule. #
################################
{...}: {
  programs.nixvim = {
    # Snacks zen.
    plugins.snacks.settings.zen = {
    };

    # Zen keymaps.
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
