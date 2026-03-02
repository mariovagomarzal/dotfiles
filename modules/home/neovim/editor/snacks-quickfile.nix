######################################
# Snacks quickfile plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    # Snacks quickfile.
    plugins.snacks.settings.quickfile = {
      enabled = true;

      # Excluded treesitter languages.
      exclude = ["latex"];
    };
  };
}
