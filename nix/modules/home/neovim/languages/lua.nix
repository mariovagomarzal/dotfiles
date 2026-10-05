{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    lsp.servers.lua_ls.enable = true;

    plugins.conform-nvim.settings = {
      formatters.stylua.command = lib.getExe pkgs.stylua;
      formatters_by_ft.lua = ["stylua"];
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.lua
    ];
  };
}
