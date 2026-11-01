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
    # workaround: julia-bin 1.13.2 is not cached for aarch64-darwin, and its
    # install check runs Julia's whole test suite locally. Remove when
    # cache.nixos.org has it (https://hydra.nixos.org/job/nixpkgs/unstable/julia-bin.aarch64-darwin).
    (julia-bin.overrideAttrs {doInstallCheck = false;})
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
