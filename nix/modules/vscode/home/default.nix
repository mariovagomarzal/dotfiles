{...}: {
  programs.vscode = {
    enable = true;
  };

  imports = [
    ./default-profile.nix
  ];
}
