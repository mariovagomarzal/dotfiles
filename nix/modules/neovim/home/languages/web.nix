{config, ...}: {
  programs.nixvim = {
    lsp.servers.vtsls.enable = true;

    # Prettier command is defined in `conform.nix`, the shared formatters file.
    plugins.conform-nvim.settings = {
      formatters_by_ft = {
        javascript = ["prettier"];
        typescript = ["prettier"];
        css = ["prettier"];
        html = ["prettier"];
        scss = ["prettier"];
        svelte = ["prettier"];
        vue = ["prettier"];
        typescriptreact = ["prettier"];
        javascriptreact = ["prettier"];
      };
    };

    plugins.treesitter.grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
      javascript
      typescript
      tsx
      css
      html
      scss
      svelte
      vue
    ];
  };
}
