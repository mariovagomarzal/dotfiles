############################################
# Python language support submodule. #
############################################
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Ty server.
    lsp.servers.ty.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.ruff_format.command = lib.getExe pkgs.ruff;
      formatters_by_ft.python = ["ruff_format"];
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.python
    ];
  };
}
