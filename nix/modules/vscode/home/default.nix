/**
Visual Studio Code with a default profile of extensions, settings and
keybindings.
*/
{...}: {
  programs.vscode = {
    enable = true;
  };

  imports = [
    ./default-profile.nix
  ];
}
