/**
Fonts for the terminal, the editors and typeset documents, installed for the user on every platform.

They are installed through home-manager rather than the system so that every machine gets them, including those managed
by home-manager alone: on macOS they are copied into `~/Library/Fonts`, and on Linux fontconfig finds them in the
profile.
*/
{pkgs, ...}: let
  # TeX Live ships Garamond-Math inside its TeX tree, where neither macOS nor fontconfig look for fonts.
  garamond-math = pkgs.linkFarm "garamond-math" {
    "share/fonts/opentype/Garamond-Math.otf" = "${pkgs.texlivePackages.garamond-math.tex}/fonts/opentype/public/garamond-math/Garamond-Math.otf";
  };
in {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    eb-garamond
    garamond-math
    fira-sans
    julia-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    newcomputermodern
  ];
}
