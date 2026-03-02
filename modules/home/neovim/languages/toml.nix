##########################################
# TOML language support submodule. #
##########################################
{pkgs, ...}: {
  programs.nixvim = {
    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.toml
    ];
  };
}
