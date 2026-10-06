/**
Uses the Obsidian app from Homebrew on macOS, so home-manager only manages its
configuration.
*/
_: {
  programs.obsidian.package = null;
}
