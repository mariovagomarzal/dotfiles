###################################
# Obsidian Style Settings plugin. #
###################################
{pkgs, ...}:
pkgs.buildYarnObsidianPlugin (finalAttrs: {
  pname = "obsidian-style-settings";
  version = "1.0.9";

  src = pkgs.fetchFromGitHub {
    owner = "mgmeyers";
    repo = "obsidian-style-settings";
    rev = finalAttrs.version;
    sha256 = "sha256-eNbZQ/u3mufwVX+NRJpMSk5uGVkWfW0koXKq7wg9d+I=";
  };

  postPatch = ''
    cp ${./patches/package.json} package.json
    cp ${./patches/yarn.lock} yarn.lock
  '';

  yarnLock = finalAttrs.src + "/yarn.lock";
  yarnDepsHash = "sha256-tqX09XWI3ZL9bXVdjgsAEuvfCAjnyWj5uSWGFbNApds=";
})
