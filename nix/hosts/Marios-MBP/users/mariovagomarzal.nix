{flake, ...}: {
  home.stateVersion = "25.05";

  programs.dotfiles.settings.path = "~/Projects/mariovagomarzal/dotfiles";

  imports = with flake.modules; [
    bat.home
    calibre.home
    catppuccin.home
    claude-code.home
    codex.home
    delta.home
    dotfiles.home
    direnv.home
    docker.home
    fastfetch.home
    fonts.home
    firefox.home
    fish.home
    ghostty.home
    git.home
    google-chrome.home
    jujutsu.home
    keepassxc.home
    lazygit.home
    lsd.home
    lua.home
    mpv.home
    neovim.home
    obsidian.home
    opencode.home
    packages.home
    podman.home
    ssh.home
    starship.home
    typst.home
    vesktop.home
    vscode.home
    zed.home
    zoxide.home
    ghostty.home-darwin
    calibre.home-darwin
    docker.home-darwin
    podman.home-darwin
    home-manager.home-darwin
    obsidian.home-darwin
    firefox.home-darwin
    google-chrome.home-darwin
    zed.home-darwin
    keepassxc.home-darwin
    typst.home-darwin
    mpv.home-darwin
    vesktop.home-darwin
  ];
}
