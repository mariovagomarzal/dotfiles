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
  imports = [
    # Core packages and utilities (with no special configuration).
    ./core.nix

    # SSH agent configuration.
    ./ssh.nix

    # Fish shell configuration.
    ./fish.nix

    # Starship prompt configuration.
    ./starship.nix

    # Alacrity terminal configuration.
    ./alacritty.nix
  ];
}
