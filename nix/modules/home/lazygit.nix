########################
# Lazygit home module. #
########################
{...}: {
  programs.lazygit = {
    enable = true;

    # Enable shell integrations for 'lazygit'.
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
