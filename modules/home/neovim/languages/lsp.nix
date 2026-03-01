############################################
# Neovim core LSP configuration submodule. #
############################################
{...}: {
  programs.nixvim = {
    # LSP configuration.
    lsp = {
      # LSP keybindings.
      keymaps = [
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
        }
      ];
    };

    # Use lspconfig for default LSP configurations.
    plugins.lspconfig.enable = true;

    # Diagnostics configuration.
    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      update_in_insert = false;
      underline = true;
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
      };
    };

    # Diagnostics keymaps.
    keymaps = [
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options = {
          desc = "Go to previous diagnostic";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options = {
          desc = "Go to next diagnostic";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "gl";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          desc = "Open diagnostic float";
          silent = true;
        };
      }
    ];
  };
}
