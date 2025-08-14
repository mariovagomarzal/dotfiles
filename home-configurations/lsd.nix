######################
# LSD configuration. #
######################
{...}: {
  programs.lsd = {
    enable = true;

    # Enable aliases for 'lsd'.
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    # LSD configuration content.
    settings = {
      # Layout configuration.
      layout = "grid";

      # Sorting configuration.
      sorting = {
        column = "name";
        dir-grouping = "first";
      };
    };
  };
}
