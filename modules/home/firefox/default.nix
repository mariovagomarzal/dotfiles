########################
# Firefox home module. #
########################
inputs: let
  # Auxiliary function to import a profile definition.
  importProfile = file: import file inputs;
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
      default = importProfile ./default-profile.nix;
    };
  };
}
