/**
User packages that need no configuration: development tools, language
toolchains and utilities.
*/
{pkgs, ...}: {
  home.packages = with pkgs; [
    gnupg
    gh
    just
    # Fallback used by git hooks from git-hooks.nix once their store path is
    # garbage-collected.
    prek
    devenv

    rustup
    nodejs
    elan
    julia-bin
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
