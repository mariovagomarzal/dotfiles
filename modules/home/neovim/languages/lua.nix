#########################################
# Lua language support submodule. #
#########################################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Lua Language Server.
    lsp.servers.lua_ls.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.stylua.command = lib.getExe pkgs.stylua;
      formatters_by_ft.lua = ["stylua"];
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.lua
    ];
  };
}
