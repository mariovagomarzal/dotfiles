####################################################
# Firefox web browser configuration for this user. #
####################################################
{pkgs, ...}: {
  # Use the 'nixpkgs-firefox-darwin' package, imported using overlays.
  programs.firefox.package = pkgs.firefox-bin;
}
