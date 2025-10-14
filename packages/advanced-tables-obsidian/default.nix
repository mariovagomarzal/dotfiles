####################################
# Obsidian Advanced tables plugin. #
####################################
{pkgs, ...}:
pkgs.buildNpmObsidianPlugin (finalAttrs: {
  pname = "advanced-tables-obsidian";
  version = "0.22.1";

  src = pkgs.fetchFromGitHub {
    owner = "tgrosinger";
    repo = "advanced-tables-obsidian";
    rev = finalAttrs.version;
    sha256 = "sha256-eWKn3qEYsVfOsO3LL0mj4HHOuoLvag4mcWXXDMfH2GM=";
  };

  postPatch = ''
    cp ${./patches/package.json} package.json
    cp ${./patches/package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-6gL5uYhCfyYZOvc3ymACOpEFQQzTZIQnFMTWnr6xkVU=";

  dist = ".";
})
