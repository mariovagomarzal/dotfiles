#######################
# Core home packages. #
#######################
{
  pkgs,
  userName,
  ...
}: {
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  # User information for home-manager.
  home = {
    username = userName;
    homeDirectory = "/Users/${userName}";

    # Supported version.
    stateVersion = "23.11";
  };

  # No-configuration packages.
  home.packages = with pkgs; [
    # Files related tools.
    fzf
    tree

    # Signing tools.
    gnupg

    # Python packages.
    poetry
    cookiecutter
  ];

  # Minimal configuration-dependent packages.
  programs = {
    # Pyenv.
    pyenv = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
