{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters = {
          prettier.command = lib.getExe pkgs.prettier;
        };
      };
    };

    keymaps = [
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
