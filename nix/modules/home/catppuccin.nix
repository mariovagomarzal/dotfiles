{config, ...}: {
  catppuccin = {
    # Auto-enroll every supported program/service ('autoEnable' will control
    # this once the upcoming behavior lands; 'enable' becomes a global toggle).
    autoEnable = true;
    enable = true;

    flavor = "mocha";
    accent = "mauve";
  };

  home.sessionVariables = let
    cfg = config.catppuccin;
  in {
    CATPPUCCIN_FLAVOR = cfg.flavor;
    CATPPUCCIN_ACCENT = cfg.accent;
  };
}
