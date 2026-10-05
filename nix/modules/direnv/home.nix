/**
direnv with nix-direnv for per-project Nix environments.
*/
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
