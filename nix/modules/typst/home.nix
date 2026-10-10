/**
Typst, with the [quire](https://github.com/mariovagomarzal/quire) template installed as a local package.

Quire is pinned as a flake input and linked into Typst's data directory, so documents import it as
`@local/quire:<version>`, and updating the input brings in the latest commit. The name and version come from its
`typst.toml`. The data directory differs between platforms and is set by the platform files.
*/
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  quire = (lib.importTOML "${inputs.quire}/typst.toml").package;
in {
  options.programs.typst.dataDir = lib.mkOption {
    type = lib.types.str;
    description = "Typst's data directory, where it looks for packages under `packages/<namespace>/<name>/<version>`.";
  };

  config = {
    home.packages = [pkgs.typst];

    home.file."${config.programs.typst.dataDir}/packages/local/${quire.name}/${quire.version}".source = inputs.quire;
  };
}
