####################################
# Snacks scratch plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    # Snacks scratch.
    plugins.snacks.settings.scratch = {
    };

    # Scratch keymaps.
    keymaps = [
      {
        mode = "n";
        key = "<leader>.";
        action = "<cmd>lua Snacks.scratch()<CR>";
        options.desc = "Toggle scratch buffer";
      }
      {
        mode = "n";
        key = "<leader>S";
        action = "<cmd>lua Snacks.scratch.select()<CR>";
        options.desc = "Select scratch buffer";
      }
    ];
  };
}
