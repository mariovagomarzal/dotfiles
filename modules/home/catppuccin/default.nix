###########################
# Catppuccin home module. #
###########################
{config, ...}: {
  # Global Catppuccin theme options.
  catppuccin = {
    # Enable 'catppuccin' options for every supported program/service.
    enable = true;

    # Set the flavor and accent color.
    flavor = "mocha";
    accent = "mauve";
  };

  # Session variables related to Catppuccin.
  home.sessionVariables = let
    cfg = config.catppuccin;
  in {
    CATPPUCCIN_FLAVOR = cfg.flavor;
    CATPPUCCIN_ACCENT = cfg.accent;
  };
}
