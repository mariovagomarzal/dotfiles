#########################
# Packages home module. #
#########################
{pkgs, ...}: {
  # No-configuration packages.
  home.packages = with pkgs; [
    # Core packages.
    gnupg
    git
    gh
    just
    devenv

    # Programming languages (or related).
    rustup
    nodejs
    typst
    elan
    texliveFull

    # Python-related packages.
    uv
    poetry

    # Utilities.
    cookiecutter

    # AI-related tools.
    claude-code
    gemini-cli

    # Miscellaneous.
    ghostscript
    mermaid-cli
    cmatrix
  ];

  # Minimal configuration-dependent programs and/or services.
  programs = {
    # Home Manager.
    home-manager.enable = true;
  };

  services = {};
}
