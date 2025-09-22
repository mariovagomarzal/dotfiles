##############################
# Obsidian builders overlay. #
##############################
{lib, ...}: final: prev: let
  importBuilder = lib.dotfiles.importBuilder final;
in {
  buildNpmObsidianPlugin = importBuilder ./npm-plugin.nix {};
}
