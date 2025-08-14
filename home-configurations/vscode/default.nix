#####################################
# Visual Studio Code configuration. #
#####################################
{
  lib,
  pkgs,
  config,
  usersInfo,
  ...
}: let
  userInfo = usersInfo config;

  # Auxiliary function to import a profile definition.
  importProfile = file:
    import file {
      inherit
        lib
        pkgs
        userInfo
        ;
    };
in {
  programs.vscode = {
    enable = true;

    # Profiles.
    profiles = {
      # Default profile.
      default = importProfile ./profiles/default.nix;
    };
  };
}
