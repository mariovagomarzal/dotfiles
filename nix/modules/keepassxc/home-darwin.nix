/**
Uses the official KeePassXC app from Homebrew on macOS, and starts it at login.

The build from nixpkgs is only ad-hoc signed: macOS refuses it the keychain
access that Touch ID quick unlock needs, and hides its menu bar icon when it
runs from /nix/store. The official app is signed and notarized, and installs
its own Firefox native messaging manifest.
*/
_: {
  programs.keepassxc.package = null;

  launchd.agents.keepassxc = {
    enable = true;
    config = {
      ProgramArguments = ["/Applications/KeePassXC.app/Contents/MacOS/KeePassXC"];
      RunAtLoad = true;
    };
  };
}
