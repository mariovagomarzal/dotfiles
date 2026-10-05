##################################
# Snacks scope plugin submodule. #
##################################
_: {
  programs.nixvim = {
    # Snacks scope.
    plugins.snacks.settings.scope = {
      enabled = true;
    };
  };
}
