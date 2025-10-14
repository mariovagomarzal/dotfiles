###################################
# Visual Studio Code home module. #
###################################
{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    # Profiles.
    profiles = {
      # Default profile.
      default = import ./default-profile.nix {
        inherit pkgs;
      };
    };
  };
}
