##################################
# Catppuccin theme for Obsidian. #
##################################
{pkgs, ...}:
pkgs.buildObsidianTheme {
  name = "Catppuccin";
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obsidian";
    rev = "v2.0.4";
    hash = "sha256-fbPkZXlk+TTcVwSrt6ljpmvRL+hxB74NIEygl4ICm2U=";
  };
}
