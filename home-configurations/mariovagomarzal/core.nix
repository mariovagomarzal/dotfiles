#########################################
# Core home configuration and packages. #
#########################################
{
  pkgs,
  config,
  ...
}: {
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  # User information for home-manager.
  home = {
    homeDirectory = "/Users/${config.home.username}";

    # Supported version.
    stateVersion = "23.11";
  };

  # No-configuration packages.
  home.packages = with pkgs; [
    # Core packages.
    gnupg

    # Programming languages (or related).
    rustup
    typst
    elan
    zulu

    # Python-related packages.
    uv
    poetry

    # Files related packages.
    tree

    # Miscellaneous.
    cmatrix
  ];

  # Minimal configuration-dependent programs and/or services.
  programs = {};
  services = {};
}
