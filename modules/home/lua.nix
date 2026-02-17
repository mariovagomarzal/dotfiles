####################
# Lua home module. #
####################
{pkgs, ...}: {
  # Lua programming language.
  programs.lua = {
    enable = true;
    package = pkgs.lua5_4;

    # Extra packages to be installed in the Lua environment.
    extraPackages = [
      (ps:
        with ps; [
          luarocks
        ])
    ];
  };
}
