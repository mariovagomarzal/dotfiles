##################################
# Snacks input plugin submodule. #
##################################
_: {
  programs.nixvim = {
    # Snacks input.
    plugins.snacks.settings.input = {
      enabled = true;
    };
  };
}
