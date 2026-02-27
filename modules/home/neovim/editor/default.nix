############################
# Neovim editor submodule. #
############################
{...}: {
  imports = [
    ./snacks-bufdelete.nix
    ./telescope.nix
    ./neo-tree.nix
    ./gitsigns.nix
    ./diffview.nix
    ./toggleterm.nix
    ./surround.nix
    ./comment.nix
    ./project.nix
  ];
}
