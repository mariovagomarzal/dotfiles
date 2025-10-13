###################################
# Visual Studio Code home module. #
###################################
inputs: let
  # Auxiliary function to import a profile definition.
  importProfile = file: import file inputs;
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
