##########################################
# Just language support submodule. #
##########################################
_: {
  programs.nixvim = {
    # Just Language Server.
    lsp.servers.just.enable = true;
  };
}
