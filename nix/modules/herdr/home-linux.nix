/**
Herdr on Linux, for now without the desktop app.
*/
_: {
  # workaround: the Herdr desktop app is not in nixpkgs, so Linux has no
  # desktop app while macOS installs it as a cask. Install it here from
  # nixpkgs, with herdr-core, when nixpkgs has `herdr-app`
  # (https://github.com/herdrdev/herdr-app).
}
