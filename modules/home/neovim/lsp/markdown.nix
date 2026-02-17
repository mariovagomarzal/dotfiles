###########################
# Markdown LSP submodule. #
###########################
{...}: {
  programs.nixvim = {
    lsp.servers.marksman.enable = true;

    files."ftplugin/markdown.lua" = {
      opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };
  };
}
