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
            alejandra.command = exe "alejandra";
            stylua.command = exe "stylua";
            shfmt.command = exe "shfmt";
            prettier.command = exe "prettier";
            ruff_format.command = exe "ruff";
            typststyle.command = exe "typstyle";
          };

          # Formatters by filetype.
          formatters_by_ft = {
            nix = ["alejandra"];
            lua = ["stylua"];
            sh = ["shfmt"];
            bash = ["shfmt"];
            javascript = ["prettier"];
            typescript = ["prettier"];
            json = ["prettier"];
            yaml = ["prettier"];
            markdown = ["prettier"];
            python = ["ruff_format"];
            typst = ["typststyle"];
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
