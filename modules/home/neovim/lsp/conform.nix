####################################
# Neovim Conform plugin submodule. #
####################################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      # Conform.
      conform-nvim = {
        enable = true;
        settings = {
          # Formatter commands.
          formatters = let
            exe = name: lib.getExe pkgs.${name};
          in {
            stylua.command = exe "stylua";
            shfmt.command = exe "shfmt";
            prettier.command = exe "prettier";
            ruff_format.command = exe "ruff";
          };

          # Formatters by filetype.
          formatters_by_ft = {
            lua = ["stylua"];
            sh = ["shfmt"];
            bash = ["shfmt"];
            javascript = ["prettier"];
            typescript = ["prettier"];
            json = ["prettier"];
            yaml = ["prettier"];
            python = ["ruff_format"];
          };
        };
      };
    };

    # Conform keymaps.
    keymaps = [
      # Format buffer.
      {
        mode = "n";
        key = "<leader>cf";
        action = ''<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<CR>'';
        options = {
          desc = "Format buffer";
          silent = true;
        };
      }
    ];
  };
}
