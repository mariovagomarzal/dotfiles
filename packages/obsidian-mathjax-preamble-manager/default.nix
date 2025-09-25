#############################################
# Obsidian MathJax Preamble Manager plugin. #
#############################################
{
  buildNpmObsidianPlugin,
  fetchFromGitHub,
}:
buildNpmObsidianPlugin (finalAttrs: {
  pname = "obsidian-mathjax-preamble-manager";
  version = "0.2.10";

  src = fetchFromGitHub {
    owner = "RyotaUshio";
    repo = "obsidian-mathjax-preamble-manager";
    rev = finalAttrs.version;
    sha256 = "sha256-IkwobdbLQogfXs+OkFKFnenWoY6SYSj0vgZ8lNmTBOM=";
  };

  npmDepsHash = "sha256-5eJ0eeHLuON6g//RTt/tJ1Jj0VdvSUu6DtIUiwRatvE=";

  dist = ".";
})
