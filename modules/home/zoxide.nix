#######################
# Zoxide home module. #
#######################
{...}: {
  programs.zoxide = {
    enable = true;

    # Extra shell aliases to add.
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
