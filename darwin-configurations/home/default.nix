###########################################
# Homa-manager configuration entry point. #
###########################################
{userName, ...}: {
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  # User information for home-manager.
  home = {
    username = userName;
    homeDirectory = "/Users/${userName}";

    # Supported version.
    stateVersion = "23.11";
  };

  # Home-manager imports.
  imports = [];
}
