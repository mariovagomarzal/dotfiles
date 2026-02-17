########################
# Typst LSP submodule. #
########################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Tinymist server.
    lsp.servers.tinymist.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.typststyle.command = lib.getExe pkgs.typstyle;
      formatters_by_ft.typst = ["typststyle"];
    };
  };
}
