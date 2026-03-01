###################################
# Snacks indent plugin submodule. #
###################################
{...}: {
  programs.nixvim = {
    # Snacks indent.
    plugins.snacks.settings.indent = {
      enabled = true;
    };
  };
}
