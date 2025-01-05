################################################
# Core shared home configuration and packages. #
################################################
{pkgs, ...}: {
  # No-configuration packages.
  home.packages = with pkgs; [
    # Core packages.
    gnupg

    # Programming languages (or related).
    rustup
    typst

    # Python-related packages.
    uv
    poetry

    # Miscellaneous.
    cmatrix
  ];

  # Minimal configuration-dependent programs and/or services.
  programs = {};
  services = {};
}
