{config, ...}: {
  programs.nixvim = {
    lsp.servers.marksman.enable = true;

    plugins.conform-nvim.settings = {
      formatters_by_ft.markdown = ["prettier"];
      # Prettier command is defined in `conform.nix`, the shared formatters file.
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.markdown
    ];

    files."ftplugin/markdown.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
