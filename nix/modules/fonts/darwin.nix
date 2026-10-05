/**
System fonts: FiraCode Nerd Font and New Computer Modern.
*/
{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    newcomputermodern
  ];
}
