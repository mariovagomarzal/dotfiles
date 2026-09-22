###########################################
# Typst language support submodule. #
###########################################
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Tinymist server.
    lsp.servers.tinymist.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.typststyle.command = lib.getExe pkgs.typstyle;
      formatters_by_ft.typst = ["typststyle"];
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.typst
    ];
  };
}
