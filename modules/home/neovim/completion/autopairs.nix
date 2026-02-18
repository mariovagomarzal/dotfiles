######################################
# Neovim Autopairs plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Autopairs.
      nvim-autopairs = {
        enable = true;

        settings = {
          # Treesitter integration.
          check_ts = true;
        };
      };
    };
  };
}
