{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    lsp.servers.tinymist.enable = true;

    plugins.conform-nvim.settings = {
      formatters.typststyle.command = lib.getExe pkgs.typstyle;
      formatters_by_ft.typst = ["typststyle"];
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.typst
    ];
  };
}
