{flake, ...}: {
  home.stateVersion = "25.05";

  imports = with flake.modules; [
    alacritty.home
    bat.home
    catppuccin.home
    claude-code.home
    delta.home
    direnv.home
    fastfetch.home
    firefox.home
    fish.home
    git.home
    jujutsu.home
    lazygit.home
    lsd.home
    lua.home
    neovim.home
    obsidian.home
    packages.home
    ssh.home
    starship.home
    vscode.home
    zed.home
    zoxide.home
    aerospace.home-darwin
    firefox.home-darwin
    zed.home-darwin
  ];
}
