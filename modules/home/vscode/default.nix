###################################
# Visual Studio Code home module. #
###################################
{
  lib,
  pkgs,
  config,
  ...
}: let
  # Auxiliary function to import a profile definition.
  importProfile = file:
    import file {
      inherit
        lib
        pkgs
        ;
    };
in {
  programs.vscode = {
    enable = true;

    # Profiles.
    profiles = {
      # Default profile.
      default = importProfile ./default-profile.nix;
    };
  };
}
