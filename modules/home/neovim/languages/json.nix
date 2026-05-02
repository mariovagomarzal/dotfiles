##########################################
# JSON language support submodule. #
##########################################
{config, ...}: {
  programs.nixvim = {
    # JSON Language Server.
    lsp.servers.jsonls.enable = true;

    # Conform formatter.
    # Prettier command is defined in `conform.nix`, the shared formatters file.
    plugins.conform-nvim.settings = {
      formatters_by_ft.json = ["prettier"];
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.json
    ];
  };
}
