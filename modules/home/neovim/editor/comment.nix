####################################
# Neovim Comment plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Comment.
      comment = {
        enable = true;

        settings = {
          # Padding around comment delimiters.
          padding = true;
          # Keep cursor at its position after commenting.
          sticky = true;
        };
      };
    };
  };
}
