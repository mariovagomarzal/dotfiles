{flake, ...}: let
  inherit (flake.modules) home home-darwin;
in {
  home.stateVersion = "25.05";

  imports = [
    home.alacritty
    home.bat
    home.catppuccin
    home.claude-code
    home.core
    home.delta
    home.direnv
    home.fastfetch
    home.firefox
    home.fish
    home.git
    home.jujutsu
    home.lazygit
    home.lsd
    home.lua
    home.neovim
    home.obsidian
    home.options
    home.packages
    home.ssh
    home.starship
    home.vscode
    home.zed
    home.zoxide
    home-darwin.aerospace
    home-darwin.core
    home-darwin.firefox
    home-darwin.options
    home-darwin.zed
  ];
}
