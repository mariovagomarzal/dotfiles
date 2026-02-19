####################################
# Neovim Conform plugin submodule. #
####################################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Conform.
    plugins.conform-nvim = {
      enable = true;

      settings = {
        # Shared formatter commands.
        formatters = {
          prettier.command = lib.getExe pkgs.prettier;
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
