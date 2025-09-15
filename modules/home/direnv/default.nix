#######################
# Direnv home module. #
#######################
{...}: {
  programs.direnv = {
    enable = true;

    # Enable Bash and Zsh integration. Fish is enabled by default.
    enableBashIntegration = true;
    enableZshIntegration = true;

    # Enable Nix integration.
    nix-direnv.enable = true;

    # Direnv configuration content.
    config = {};

    # Direnv startup content.
    stdlib = "";
  };
}
