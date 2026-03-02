####################################
# Neovim Comment plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    # Comment.
    plugins.comment = {
      enable = true;

      settings = {
        # Padding around comment delimiters.
        padding = true;
        # Keep cursor at its position after commenting.
        sticky = true;
      };
    };
  };
}
