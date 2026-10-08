/**
Uses the Firefox app from Homebrew on macOS, so home-manager only manages the
profile.

Policies still apply, through the macOS defaults domain of Firefox.
*/
_: {
  programs.firefox.package = null;
}
