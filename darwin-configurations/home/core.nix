#######################
# Core home packages. #
#######################
{pkgs, ...}: {
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
