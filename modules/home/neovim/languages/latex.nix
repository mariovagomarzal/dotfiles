##########################################
# LaTeX language support submodule. #
##########################################
{pkgs, ...}: {
  programs.nixvim = {
    # Texlab server.
    lsp.servers.texlab.enable = true;

    # TODO: Investigate how to use Conform for LaTeX.

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.latex
    ];

    # Filetype settings.
    files."ftplugin/tex.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
