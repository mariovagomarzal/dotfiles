#####################################
# Neovim Surround plugin submodule. #
#####################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Surround.
      nvim-surround.enable = true;
    };
  };
}
