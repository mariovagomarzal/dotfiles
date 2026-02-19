#########################################
# Nix language support submodule. #
#########################################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Nil LS server.
    lsp.servers.nil_ls.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.alejandra.command = lib.getExe pkgs.alejandra;
      formatters_by_ft.nix = ["alejandra"];
    };

    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.nix
    ];

    # Filetype settings.
    files."ftplugin/nix.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
