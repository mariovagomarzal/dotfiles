###################################
# Neovim Fidget plugin submodule. #
###################################
{...}: {
  programs.nixvim = {
    # Fidget.
    plugins.fidget = {
      enable = true;

      settings = {
        notification.window.winblend = 0;
      };
    };
  };
}
