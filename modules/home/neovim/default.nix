#######################
# Neovim home module. #
#######################
{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    nixpkgs.config = {
      allowUnfree = true;
    };

    # Dependencies.
    dependencies = {
      tree-sitter.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
    };
  };

  imports = [
    ./vim
    ./lsp
    ./completion
    ./editor
    ./ui
  ];
}
