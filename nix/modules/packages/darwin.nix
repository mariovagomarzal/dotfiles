/**
System-wide packages, with Vim as the system's default editor.
*/
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
