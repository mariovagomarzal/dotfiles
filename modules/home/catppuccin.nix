###########################
# Catppuccin home module. #
###########################
{config, ...}: {
  # Global Catppuccin theme options.
  catppuccin = {
    # Auto-enroll every supported program/service ('autoEnable' will control
    # this once the upcoming behavior lands; 'enable' becomes a global toggle).
    autoEnable = true;
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
