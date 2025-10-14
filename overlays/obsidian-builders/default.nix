##############################
# Obsidian builders overlay. #
##############################
final: _: let
  importBuilder = file: overrides: final.callPackage file overrides;
in {
  buildNpmObsidianPlugin = importBuilder ./npm-plugin.nix {};
  buildPnpmObsidianPlugin = importBuilder ./pnpm-plugin.nix {
    pnpm = final.pnpm_9;
  };
  buildYarnObsidianPlugin = importBuilder ./yarn-plugin.nix {};
  buildObsidianTheme = importBuilder ./theme.nix {};
}
