####################
# Delta home module. #
####################
{...}: {
  programs.delta = {
    enable = true;

    # Enable git integration.
    enableGitIntegration = true;
  };
}
