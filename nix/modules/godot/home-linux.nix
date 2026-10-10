/**
Godot on Linux, from nixpkgs.
*/
{pkgs, ...}: {
  home.packages = [pkgs.godot];
}
