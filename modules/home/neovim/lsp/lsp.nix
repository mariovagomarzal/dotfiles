############################################
# Neovim core LSP configuration submodule. #
############################################
{...}: {
  programs.nixvim = {
    # LSP configuration.
    lsp = {
      # LSP servers with default configurations.
      servers = {
        bashls.enable = true;
        jsonls.enable = true;
        just.enable = true;
        lua_ls.enable = true;
        vtsls.enable = true;
        yamlls.enable = true;
        ty.enable = true;
      };

      # LSP keybindings.
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "declaration";
        }
        {
          key = "gi";
          lspBufAction = "implementation";
        }
        {
          key = "gt";
          lspBufAction = "type_definition";
        }
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
        {
          key = "[d";
          action = "<CMD>lua vim.diagnostic.goto_prev()<Enter>";
        }
        {
          key = "]d";
          action = "<CMD>lua vim.diagnostic.goto_next()<Enter>";
        }
        {
          key = "gl";
          action = "<CMD>lua vim.diagnostic.open_float()<Enter>";
        }
      ];
    };

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

    plugins = {
      # Use lspconfig for default LSP configurations.
      lspconfig.enable = true;
    };
  };
}
