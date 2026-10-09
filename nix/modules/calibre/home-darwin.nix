/**
Uses the calibre app from Homebrew on macOS, since the nixpkgs package is marked
broken on Darwin.
*/
_: {
  programs.calibre.package = null;
}
