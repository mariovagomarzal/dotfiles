###########################
# Neovim icons submodule. #
###########################
{...}: {
  programs.nixvim = {
    plugins = {
      # Icon support with mini.icons.
      mini-icons = {
        enable = true;
        mockDevIcons = true;
      };
    };
  };
}
