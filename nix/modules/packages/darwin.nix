{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    gnupg
    just

    vim

    python312

    aria2
  ];

  environment.variables.EDITOR = "vim";
}
