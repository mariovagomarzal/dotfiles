/**
Typst's data directory on macOS, inside `~/Library/Application Support` rather than the XDG one.
*/
{config, ...}: {
  programs.typst.dataDir = "${config.home.homeDirectory}/Library/Application Support/typst";
}
