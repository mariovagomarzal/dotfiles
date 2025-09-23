##################################
# Catppuccin theme for Obsidian. #
##################################
{
  buildObsidianTheme,
  fetchFromGitHub,
}:
buildObsidianTheme {
  name = "Catppuccin";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "obsidian";
    rev = "v2.0.4";
    hash = "sha256-fbPkZXlk+TTcVwSrt6ljpmvRL+hxB74NIEygl4ICm2U=";
  };
}
