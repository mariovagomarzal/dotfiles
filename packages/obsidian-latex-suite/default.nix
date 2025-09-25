################################
# Obsidian LaTeX Suite plugin. #
################################
{
  buildNpmObsidianPlugin,
  fetchFromGitHub,
}:
buildNpmObsidianPlugin (finalAttrs: {
  pname = "obsidian-latex-suite";
  version = "1.9.8";

  src = fetchFromGitHub {
    owner = "mariovagomarzal";
    repo = "obsidian-latex-suite";
    rev = "d102585985cab41059d9987e8aca34170964a468";
    sha256 = "sha256-zmrnGMJKlkI4o0AI48VTDAWW8AOo5urKu6t86INXuEw=";
  };

  npmDepsHash = "sha256-ShqceMSp8HzDOzwm4vn9ACJwnr83/CyOrqZgfMmyiF8=";

  dist = ".";
})
