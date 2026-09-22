##################################
# Snacks image plugin submodule. #
##################################
{...}: {
  programs.nixvim = {
    # Snacks image.
    plugins.snacks.settings.image = {
      enabled = true;
    };
  };
}
