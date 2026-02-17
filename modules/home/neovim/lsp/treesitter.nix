#######################################
# Neovim Treesitter plugin submodule. #
#######################################
{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      # Treesitter.
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
          python
          lua
          bash
          markdown
          json
          toml
          yaml
        ];
        settings = {
          # Syntax highlighting.
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };

          # Indentation.
          indent.enable = true;

          # Folding.
          folding.enable = true;

          # Incremental selection.
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              node_decremental = "<BS>";
              scope_incremental = false;
            };
          };
        };
      };
    };
  };
}
