##############################
# Obsidian builders overlay. #
##############################
{lib, ...}: final: prev: let
  importBuilder = lib.dotfiles.importBuilder final;
in {
  buildNpmObsidianPlugin = importBuilder ./npm-plugin.nix {};
  buildPnpmObsidianPlugin = importBuilder ./pnpm-plugin.nix {
    pnpm = final.pnpm_9;
  };
  buildYarnObsidianPlugin = importBuilder ./yarn-plugin.nix {};
  buildObsidianTheme = importBuilder ./theme.nix {};
}
