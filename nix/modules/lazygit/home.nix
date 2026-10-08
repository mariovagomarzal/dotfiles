/**
lazygit, with shell integration for Bash, Zsh and Fish.
*/
_: {
  programs.lazygit = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
