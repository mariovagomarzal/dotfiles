/**
Uses the prebuilt Firefox binary on macOS.

`firefox-bin` comes from the nixpkgs-firefox-darwin overlay. It is wrapped in
`makeOverridable` because the home-manager module overrides the package.
*/
{
  pkgs,
  lib,
  ...
}: {
  programs.firefox.package = lib.makeOverridable (_: pkgs.firefox-bin) {};
}
