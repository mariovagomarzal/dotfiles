##################################
# Snacks image plugin submodule. #
##################################
_: {
  programs.nixvim = {
    # Snacks image.
    plugins.snacks.settings.image = {
      enabled = true;
    };
  };
}
