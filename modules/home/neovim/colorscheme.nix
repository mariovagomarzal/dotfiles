###################################
# Neovim colorscheme home module. #
###################################
{...}: {
  programs.nixvim = {
    # Catppuccin colorscheme configuration.
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        integrations = {};
      };
    };
  };
}
