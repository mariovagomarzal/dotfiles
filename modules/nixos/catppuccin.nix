############################
# Catppuccin NixOS module. #
############################
{...}: {
  # Global Catppuccin theme options.
  catppuccin = {
    # Enable 'catppuccin' options for every supported program/service.
    enable = true;

    # Set the flavor and accent color.
    flavor = "mocha";
    accent = "mauve";
  };
}
