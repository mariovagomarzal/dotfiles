##########################################
# Bash language support submodule. #
##########################################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Bash Language Server.
    lsp.servers.bashls.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.shfmt.command = lib.getExe pkgs.shfmt;
      formatters_by_ft = {
        sh = ["shfmt"];
        bash = ["shfmt"];
      };
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.bash
    ];
  };
}
