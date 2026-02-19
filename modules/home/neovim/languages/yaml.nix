##########################################
# YAML language support submodule. #
##########################################
{pkgs, ...}: {
  programs.nixvim = {
    # YAML Language Server.
    lsp.servers.yamlls.enable = true;

    # Conform formatter.
    # Prettier command is defined in `conform.nix`, the shared formatters file.
    plugins.conform-nvim.settings = {
      formatters_by_ft.yaml = ["prettier"];
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.yaml
    ];
  };
}
