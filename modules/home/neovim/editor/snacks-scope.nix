##################################
# Snacks scope plugin submodule. #
##################################
{...}: {
  programs.nixvim = {
    # Snacks scope.
    plugins.snacks.settings.scope = {
      enabled = true;
    };
  };
}
