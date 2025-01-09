######################################
# Firefox web browser configuration. #
######################################
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
  programs.firefox = {
    enable = true;

    # Language packs.
    languagePacks = [
      "en-US"
      "es-ES"
    ];

    # Policies.
    # NOTE: Policies are not working with `nixpkgs-firefox-darwin`. See:
    #   https://github.com/bandithedoge/nixpkgs-firefox-darwin/issues/7
    policies = {};

    # Profiles.
    profiles = {
      # Default profile.
      default = importProfile ./profiles/default.nix;
    };
  };
}
