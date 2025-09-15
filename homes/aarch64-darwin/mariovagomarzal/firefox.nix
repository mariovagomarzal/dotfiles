#######################################
# Firefox module for mariovagomarzal. #
#######################################
{pkgs, ...}: {
  programs.firefox.package = pkgs.firefox-bin;
}
