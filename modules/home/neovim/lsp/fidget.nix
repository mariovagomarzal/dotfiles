###################################
# Neovim Fidget plugin submodule. #
###################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Fidget.
      fidget = {
        enable = true;

        settings = {
          notification.window.winblend = 0;
        };
      };
    };
  };
}
