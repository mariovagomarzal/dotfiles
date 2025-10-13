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
    typst
    elan
    texliveFull

    # Python-related packages.
    uv
    poetry

    # AI-related tools.
    claude-code

    # Miscellaneous.
    cmatrix
  ];

  # Minimal configuration-dependent programs and/or services.
  programs = {
    # Home Manager.
    home-manager.enable = true;

    # Lua programming language.
    lua = {
      enable = true;
      package = pkgs.lua5_4;
      extraPackages = [
        (ps:
          with ps; [
            luarocks
          ])
      ];
    };
  };

  services = {};
}
