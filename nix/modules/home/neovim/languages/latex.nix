##########################################
# LaTeX language support submodule. #
##########################################
{config, ...}: {
  programs.nixvim = {
    # Texlab server.
    lsp.servers.texlab.enable = true;

    # TODO: Investigate how to use Conform for LaTeX.

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.latex
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
