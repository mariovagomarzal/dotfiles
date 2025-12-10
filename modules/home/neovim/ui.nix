##################################
# Neovim UI plugins home module. #
##################################
{...}: {
  programs.nixvim = {
    plugins = {
      # WhichKey.
      which-key = {
        enable = true;
        settings = {
          # Display timeout.
          delay = 300;

          # Icons.
          icons = {
            breadcrumb = "»";
            separator = "➜";
            group = "+";
          };

          # Window appearance.
          win = {
            border = "rounded";
            padding = [1 1];
          };
        };
      };
    };
  };
}
