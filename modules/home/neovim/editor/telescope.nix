######################################
# Neovim Telescope plugin submodule. #
######################################
{...}: {
  programs.nixvim = {
    # Telescope.
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
      keymaps = {
        # File finding.
        "<leader>ff" = {
          action = "find_files";
          options.desc = "Find files";
        };
        "<leader>fg" = {
          action = "live_grep";
          options.desc = "Live grep";
        };

        # Buffers.
        "<leader>fb" = {
          action = "buffers";
          options.desc = "Find buffers";
        };

        # LSP navigation.
        "<leader>fs" = {
          action = "lsp_document_symbols";
          options.desc = "LSP document symbols";
        };
        "<leader>fw" = {
          action = "lsp_workspace_symbols";
          options.desc = "LSP workspace symbols";
        };
        "gr" = {
          action = "lsp_references";
          options.desc = "LSP references";
        };
        "<leader>fd" = {
          action = "diagnostics";
          options.desc = "LSP diagnostics";
        };
      };
    };
  };
}
