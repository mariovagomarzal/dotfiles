/**
Uses the official KeePassXC app from Homebrew on macOS, and starts it at login.

The build from nixpkgs is only ad-hoc signed: macOS refuses it the keychain
access that Touch ID quick unlock needs, and hides its menu bar icon when it
runs from /nix/store. The official app is signed and notarized.

The cask is installed by nix-darwin. A Mac managed by home-manager alone has no
Homebrew, so it keeps the build from nixpkgs, without those two features.
*/
{
  config,
  lib,
  osConfig,
  ...
}: let
  withCask = osConfig != null && lib.elem "keepassxc" (map (cask: cask.name) osConfig.homebrew.casks);
  app =
    if withCask
    then "${osConfig.homebrew.caskArgs.appdir}/KeePassXC.app"
    else "${config.programs.keepassxc.package}/Applications/KeePassXC.app";
in {
  programs.keepassxc.package = lib.mkIf withCask null;

  launchd.agents.keepassxc = {
    enable = true;
    config = {
      ProgramArguments = ["${app}/Contents/MacOS/KeePassXC"];
      RunAtLoad = true;
    };
  };
}
