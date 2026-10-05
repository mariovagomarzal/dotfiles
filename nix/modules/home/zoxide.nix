#######################
# Zoxide home module. #
#######################
_: {
  programs.zoxide = {
    enable = true;

    # Extra shell aliases to add.
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
