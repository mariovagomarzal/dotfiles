{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    lsp.servers.nil_ls.enable = true;

    plugins.conform-nvim.settings = {
      formatters.alejandra.command = lib.getExe pkgs.alejandra;
      formatters_by_ft.nix = ["alejandra"];
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.nix
    ];

    files."ftplugin/nix.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
