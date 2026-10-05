{config, ...}: {
  programs.nixvim = {
    lsp.servers.jsonls.enable = true;

    # Prettier command is defined in `conform.nix`, the shared formatters file.
    plugins.conform-nvim.settings = {
      formatters_by_ft.json = ["prettier"];
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.json
    ];
  };
}
