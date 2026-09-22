##########################################
# Just language support submodule. #
##########################################
{...}: {
  programs.nixvim = {
    # Just Language Server.
    lsp.servers.just.enable = true;
  };
}
