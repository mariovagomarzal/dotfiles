{inputs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    nixpkgs.config = {
      allowUnfree = true;
    };

    dependencies = {
      tree-sitter.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      imagemagick.enable = true;
    };
  };

  imports = [
    inputs.nixvim.homeModules.nixvim
    ./vim
    ./languages
    ./completion
    ./editor
    ./ui
    ./snacks.nix
  ];
}
