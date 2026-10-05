###################################
# Snacks indent plugin submodule. #
###################################
_: {
  programs.nixvim = {
    # Snacks indent.
    plugins.snacks.settings.indent = {
      enabled = true;
    };
  };
}
