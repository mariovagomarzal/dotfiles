{config, ...}: {
  programs.nixvim = {
    lsp.servers.yamlls.enable = true;

    # Prettier command is defined in `conform.nix`, the shared formatters file.
    plugins.conform-nvim.settings = {
      formatters_by_ft.yaml = ["prettier"];
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.yaml
    ];
  };
}
