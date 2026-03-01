##################################
# Snacks input plugin submodule. #
##################################
{...}: {
  programs.nixvim = {
    # Snacks input.
    plugins.snacks.settings.input = {
      enabled = true;
    };
  };
}
