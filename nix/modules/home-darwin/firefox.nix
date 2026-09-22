##############################
# Firefox module for Darwin. #
##############################
{
  pkgs,
  lib,
  ...
}: {
  programs.firefox.package = lib.makeOverridable ({...}: pkgs.firefox-bin) {};
}
