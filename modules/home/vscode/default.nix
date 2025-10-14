###################################
# Visual Studio Code home module. #
###################################
{...}: {
  programs.vscode = {
    enable = true;
  };

  # Imports for profile definitions.
  imports = [
    ./default-profile.nix
  ];
}
