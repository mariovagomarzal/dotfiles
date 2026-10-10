{flake, ...}: {
  home.stateVersion = "25.05";

  programs.dotfiles.settings.path = "~/Projects/mariovagomarzal/dotfiles";

  imports = with flake.modules; [
    alacritty.home
    bat.home
    calibre.home
    catppuccin.home
    claude-code.home
    codex.home
    delta.home
    dotfiles.home
    direnv.home
    fastfetch.home
    fonts.home
    firefox.home
    fish.home
    git.home
    jujutsu.home
    keepassxc.home
    lazygit.home
    lsd.home
    lua.home
    mpv.home
    neovim.home
    obsidian.home
    packages.home
    ssh.home
    starship.home
    vesktop.home
    vscode.home
    zed.home
    zoxide.home
    alacritty.home-darwin
    calibre.home-darwin
    home-manager.home-darwin
    obsidian.home-darwin
    firefox.home-darwin
    zed.home-darwin
    keepassxc.home-darwin
    mpv.home-darwin
    vesktop.home-darwin
  ];
}
