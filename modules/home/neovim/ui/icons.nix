###########################
# Neovim icons submodule. #
###########################
{...}: {
  programs.nixvim = {
    # Icon support with mini.icons.
    plugins.mini-icons = {
      enable = true;
      mockDevIcons = true;
    };
  };
}
