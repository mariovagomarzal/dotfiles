/**
Uses the Ghostty app from Homebrew on macOS, so home-manager only manages its
configuration.
*/
_: {
  programs.ghostty.package = null;
}
