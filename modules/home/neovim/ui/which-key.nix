######################################
# Neovim Which-Key plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    plugins = {
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

          # Group labels.
          spec = [
            {
              __unkeyed-1 = "<leader>b";
              group = "Buffers";
              icon = {
                icon = " ";
                color = "blue";
              };
            }
            {
              __unkeyed-1 = "<leader>c";
              group = "Code";
              icon = {
                icon = " ";
                color = "orange";
              };
            }
            {
              __unkeyed-1 = "<leader>f";
              group = "Find";
              icon = {
                icon = " ";
                color = "green";
              };
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "Git";
              icon = {
                cat = "filetype";
                name = "git";
              };
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
              # icon = {
              #   icon = " ";
              #   color = "red";
              # };
            }
          ];
        };
      };
    };
  };
}
