######################################
# Snacks quickfile plugin submodule. #
######################################
_: {
  programs.nixvim = {
    # Snacks quickfile.
    plugins.snacks.settings.quickfile = {
      enabled = true;

      # Excluded treesitter languages.
      exclude = ["latex"];
    };
  };
}
