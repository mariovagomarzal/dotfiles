##########################################
# Web language support submodule.   #
##########################################
{pkgs, ...}: {
  programs.nixvim = {
    # VtsLS server (JavaScript/TypeScript/TSX/JSX).
    lsp.servers.vtsls.enable = true;

    # Conform formatter.
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
        typescriptreact = ["prettier"]; # for .tsx files
        javascriptreact = ["prettier"]; # for .jsx files
      };
    };

    # Treesitter grammars.
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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
