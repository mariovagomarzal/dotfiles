/**
Telegram on Linux, from nixpkgs.
*/
{pkgs, ...}: {
  home.packages = [pkgs.telegram-desktop];
}
