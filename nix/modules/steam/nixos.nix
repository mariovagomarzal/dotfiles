/**
Steam on NixOS, through its system module, which sets up the 32-bit libraries and device access games need.
*/
_: {
  programs.steam.enable = true;
}
