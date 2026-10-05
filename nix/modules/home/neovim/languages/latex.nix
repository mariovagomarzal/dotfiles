{config, ...}: {
  programs.nixvim = {
    lsp.servers.texlab.enable = true;

    # TODO: Investigate how to use Conform for LaTeX.

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.latex
    ];

    files."ftplugin/tex.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
