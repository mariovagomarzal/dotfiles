##################################
# Neovim UI plugins home module. #
##################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Icon support with mini.icons.
      mini-icons = {
        enable = true;
        mockDevIcons = true;
      };

      # Which-Key.
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
