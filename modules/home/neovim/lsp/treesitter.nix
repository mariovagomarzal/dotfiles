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
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent.enable = true;
          folding.enable = true;
        };
      };
    };
  };
}
