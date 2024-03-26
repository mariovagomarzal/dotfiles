#######################
# Core home packages. #
#######################
{pkgs, ...}: {
  # home.packages = with pkgs; [];

  # Minimal configuration-dependent packages.
  programs = {
    # Pyenv.
    pyenv = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
