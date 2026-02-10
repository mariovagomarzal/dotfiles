#######################
# Neovim home module. #
#######################
{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = false; # TODO: Use as default editor when ready.
    viAlias = true;
    vimAlias = true;

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
