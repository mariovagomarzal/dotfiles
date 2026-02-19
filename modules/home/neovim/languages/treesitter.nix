#######################################
# Neovim Treesitter plugin submodule. #
#######################################
{...}: {
  programs.nixvim = {
    # Treesitter.
    plugins.treesitter = {
      enable = true;
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
}
