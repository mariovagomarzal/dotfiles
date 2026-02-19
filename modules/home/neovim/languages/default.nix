################################
# Neovim languages submodule. #
################################
{...}: {
  imports = [
    ./lsp.nix
    ./fidget.nix
    ./treesitter.nix
    ./conform.nix
    ./bash.nix
    ./json.nix
    ./just.nix
    ./lua.nix
    ./javascript.nix
    ./yaml.nix
    ./python.nix
    ./toml.nix
    ./nix.nix
    ./markdown.nix
    ./typst.nix
  ];
}
