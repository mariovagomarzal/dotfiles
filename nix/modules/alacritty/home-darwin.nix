/**
Uses the Alacritty app from Homebrew on macOS, so home-manager only manages its
configuration.
*/
_: {
  programs.alacritty.package = null;
}
