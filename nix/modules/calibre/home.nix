/**
calibre for managing and converting e-books.

Its preferences stay in the app, which rewrites them on every change. Plugins
declared with `programs.calibre.plugins` are linked into `~/.config/calibre`,
which calibre only reads on Linux.
*/
_: {
  programs.calibre.enable = true;
}
