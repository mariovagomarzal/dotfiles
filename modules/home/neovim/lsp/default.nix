#########################
# Neovim LSP submodule. #
#########################
{...}: {
  imports = [
    ./lsp.nix
    ./fidget.nix
    ./treesitter.nix
    ./conform.nix
    ./nix.nix
    ./markdown.nix
  ];
}
