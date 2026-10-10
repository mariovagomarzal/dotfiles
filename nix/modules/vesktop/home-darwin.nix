/**
Uses the Vesktop app from Homebrew on macOS, so home-manager only manages its
configuration.
*/
_: {
  programs.vesktop.package = null;
}
