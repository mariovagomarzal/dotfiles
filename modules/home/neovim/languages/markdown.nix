##############################################
# Markdown language support submodule. #
##############################################
{pkgs, ...}: {
  programs.nixvim = {
    # Marksman server.
    lsp.servers.marksman.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters_by_ft.markdown = ["prettier"];
      # Prettier command is defined in `conform.nix`, the shared formatters file.
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.markdown
    ];

    # Filetype settings.
    files."ftplugin/markdown.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
