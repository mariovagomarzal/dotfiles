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
    owner = "artisticat1";
    repo = "obsidian-latex-suite";
    rev = finalAttrs.version;
    sha256 = "sha256-TtshzrHDnXG8xSGQvEmCrFLaEM8ckVrZLG1q6RBwHvo=";
  };

  postPatch = ''
    cp ${./patches/package.json} package.json
    cp ${./patches/package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-ShqceMSp8HzDOzwm4vn9ACJwnr83/CyOrqZgfMmyiF8=";

  dist = ".";
})
