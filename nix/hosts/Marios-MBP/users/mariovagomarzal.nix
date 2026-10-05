{flake, ...}: let
  inherit
    (flake.lib.modules)
    modulesWithout
    ;
in {
  home.stateVersion = "25.05";

  imports = modulesWithout {
    "home" = [];
    "home-darwin" = [];
  };
}
