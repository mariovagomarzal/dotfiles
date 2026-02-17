########################
# Typst LSP submodule. #
########################
{...}: {
  programs.nixvim = {
    lsp.servers.tinymist.enable = true;
  };
}
