/**
Typst's data directory on Linux, under `$XDG_DATA_HOME`.
*/
{config, ...}: {
  programs.typst.dataDir = "${config.xdg.dataHome}/typst";
}
