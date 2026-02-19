################################################
# JavaScript language support submodule. #
################################################
{pkgs, ...}: {
  programs.nixvim = {
    # VtsLS server (JavaScript/TypeScript).
    lsp.servers.vtsls.enable = true;

    # Conform formatter.
    # Prettier command is defined in `conform.nix`, the shared formatters file.
    plugins.conform-nvim.settings = {
      formatters_by_ft = {
        javascript = ["prettier"];
        typescript = ["prettier"];
      };
    };

    # Treesitter grammars.
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      typescript
    ];
  };
}
