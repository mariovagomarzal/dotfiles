######################
# Nix LSP submodule. #
######################
{...}: {
  programs.nixvim = {
    lsp.servers.nil_ls.enable = true;

    files."ftplugin/nix.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
