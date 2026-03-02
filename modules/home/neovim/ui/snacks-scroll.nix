##################################
# Snacks scroll lugin submodule. #
##################################
{...}: {
  programs.nixvim = {
    # Snacks scroll.
    plugins.snacks.settings.scroll = {
      enabled = true;
    };
  };
}
