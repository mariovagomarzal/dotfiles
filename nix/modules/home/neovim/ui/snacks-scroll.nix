##################################
# Snacks scroll lugin submodule. #
##################################
_: {
  programs.nixvim = {
    # Snacks scroll.
    plugins.snacks.settings.scroll = {
      enabled = true;
    };
  };
}
