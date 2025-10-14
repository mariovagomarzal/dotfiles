##############################
# Firefox module for Darwin. #
##############################
{pkgs, ...}: {
  programs.firefox.package = pkgs.firefox-bin;
}
