_: {
  programs.direnv = {
    enable = true;

    # Fish integration is enabled by default.
    enableBashIntegration = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;

    config = {};

    stdlib = "";
  };
}
