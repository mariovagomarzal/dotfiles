################################
# Builder for Obsidian themes. #
################################
{
  lib,
  runCommand,
}: {
  name,
  src,
  rootDir ? ".",
  extraFiles ? [],
}: let
  files =
    [
      "manifest.json"
      "theme.css"
    ]
    ++ extraFiles;

  parsedFiles =
    lib.concatStringsSep
    " "
    (map (file: "${src}/${rootDir}/${file}") files);
in
  runCommand name {
    inherit src;
  } ''
    mkdir -p $out
    cp ${parsedFiles} $out/
  ''
