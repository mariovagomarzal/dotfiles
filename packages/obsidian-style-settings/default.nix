###################################
# Obsidian Style Settings plugin. #
###################################
{
  buildYarnObsidianPlugin,
  fetchFromGitHub,
}:
buildYarnObsidianPlugin (finalAttrs: {
  pname = "obsidian-style-settings";
  version = "1.0.9";

  src = fetchFromGitHub {
    owner = "mariovagomarzal";
    repo = "obsidian-style-settings";
    rev = "359c481a24f811c009f9c2812c5188ec968ced17";
    sha256 = "sha256-6xyp5PE4mhKYP3Lc4vKUG/N3aqBhHGwsCuzfVkq1jwM=";
  };

  yarnLock = finalAttrs.src + "/yarn.lock";
  yarnDepsHash = "sha256-tqX09XWI3ZL9bXVdjgsAEuvfCAjnyWj5uSWGFbNApds=";
})
