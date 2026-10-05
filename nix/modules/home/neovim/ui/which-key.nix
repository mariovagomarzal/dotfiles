_: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      settings = {
        delay = 300;

        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };

        win = {
          border = "rounded";
          padding = [1 1];
        };

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
