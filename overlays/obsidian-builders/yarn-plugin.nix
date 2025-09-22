############################################
# Builder for yarn-based Obsidian plugins. #
############################################
{
  lib,
  stdenv,
  nodejs,
  yarnConfigHook,
  yarnBuildHook,
  cctools,
  fetchYarnDeps,
}: let
  yarnHooks = {
    inherit
      yarnConfigHook
      yarnBuildHook
      ;
  };
in
  lib.extendMkDerivation {
    constructDrv = stdenv.mkDerivation;

    extendDrvArgs = finalAttrs: {
      yarnLock ? "",
      yarnDepsHash ? "",
      dist ? ".",
      nativeBuildInputs ? [],
      buildInputs ? [],
      yarnConfigHook ? null,
      yarnBuildHook ? null,
      ...
    }: {
      nativeBuildInputs =
        nativeBuildInputs
        ++ [
          nodejs
          nodejs.python
          # Prefer passed hooks.
          (
            if yarnConfigHook != null
            then yarnConfigHook
            else yarnHooks.yarnConfigHook
          )
          (
            if yarnBuildHook != null
            then yarnBuildHook
            else yarnHooks.yarnBuildHook
          )
        ]
        ++ lib.optionals stdenv.hostPlatform.isDarwin [cctools];

      buildInputs = buildInputs ++ [nodejs];

      yarnOfflineCache = fetchYarnDeps {
        inherit (finalAttrs) yarnLock;
        hash = yarnDepsHash;
      };

      installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp ${dist}/manifest.json ${dist}/main.js $out/
        [ -f ${dist}/styles.css ] && cp ${dist}/styles.css $out/

        runHook postInstall
      '';
    };
  }
