{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    lsp.servers.ty.enable = true;

    plugins.conform-nvim.settings = {
      formatters.ruff_format.command = lib.getExe pkgs.ruff;
      formatters_by_ft.python = ["ruff_format"];
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.python
    ];
  };
}
