##############################
# Firefox module for Darwin. #
##############################
{
  pkgs,
  lib,
  ...
}: {
  programs.firefox.package = lib.makeOverridable (_: pkgs.firefox-bin) {};
}
