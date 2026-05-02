##########################################
# YAML language support submodule. #
##########################################
{config, ...}: {
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
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.yaml
    ];
  };
}
