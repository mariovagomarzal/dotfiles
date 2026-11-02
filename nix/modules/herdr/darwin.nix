/**
The Herdr desktop app, as a Homebrew cask, with herdr-core built from Nix.

nixpkgs only packages the terminal client, and the app updates itself. It
needs herdr-core to run its terminals and finds it on the system PATH, so it
does not install its own copy into `~/.local/bin`.
*/
{perSystem, ...}: {
  homebrew.casks = ["herdr-app"];

  environment.systemPackages = [perSystem.self.herdr-core];
}
