######################################
# Neovim Which-Key plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    # Which-Key.
    plugins.which-key = {
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

        # Group labels.
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffer";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "Code";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Find";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "Rename";
            icon = {
              icon = " ";
              color = "cyan";
            };
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Splits";
            icon = {
              icon = "󰓩 ";
              color = "purple";
            };
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Terminal";
          }
        ];
      };
    };
  };
}
