{pkgs, ...}: {
  home.packages = with pkgs; [
    gnupg
    git
    gh
    just
    # Fallback used by git hooks from git-hooks.nix once their store path is
    # garbage-collected.
    prek
    devenv

    rustup
    nodejs
    typst
    elan
    texliveFull

    uv
    poetry

    cookiecutter

    antigravity-cli

    ghostscript
    mermaid-cli
    cmatrix
  ];

  programs = {
    home-manager.enable = true;
  };

  services = {};
}
