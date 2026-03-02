#################################
# Neovim colorscheme submodule. #
#################################
{config, ...}: {
  programs.nixvim = {
    # Catppuccin colorscheme configuration.
    colorschemes.catppuccin = {
      enable = true;

      settings = {
        transparent_background = true;
        integrations = {
          snacks = {
            enabled = true;
            indent_scope_color = config.catppuccin.accent;
          };
          which_key = true;
          dashboard = true;
          fidget = true;
          blink.style = "bordered";
          telescope.enabled = true;
          neotree = true;
          gitsigns = {
            enabled = true;
            transparent = false;
          };
          blink_pairs = true;
        };
      };
    };
  };
}
