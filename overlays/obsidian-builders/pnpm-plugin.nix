############################################
# Builder for pnpm-based Obsidian plugins. #
############################################
{
  lib,
  stdenv,
  nodejs,
  pnpm,
  cctools,
}:
lib.extendMkDerivation {
  constructDrv = stdenv.mkDerivation;

  extendDrvArgs = finalAttrs: {
    pname ? "",
    version ? "",
    src ? null,
    pnpmDepsHash ? "",
    dist ? "dist",
    pnpmDepsFetcherVersion ? 1,
    nativeBuildInputs ? [],
    buildInputs ? [],
    pnpmConfigHook ? null,
    pnpmBuildScript ? "build",
    pnpmBuildFlags ? [],
    ...
  }: {
    nativeBuildInputs =
      nativeBuildInputs
      ++ [
        nodejs
        nodejs.python
        # Prefer passed hooks.
        (
          if pnpmConfigHook != null
          then pnpmConfigHook
          else pnpm.configHook
        )
      ]
      ++ lib.optionals stdenv.hostPlatform.isDarwin [cctools];

    buildInputs = buildInputs ++ [nodejs];

    pnpmDeps = pnpm.fetchDeps {
      inherit
        (finalAttrs)
        pname
        version
        src
        ;
      fetcherVersion = pnpmDepsFetcherVersion;
      hash = pnpmDepsHash;
    };

    buildPhase = let
      pnpmBuildFlagsStr = lib.concatStringsSep " " pnpmBuildFlags;
    in ''
      runHook preBuild

      pnpm run ${pnpmBuildFlagsStr} ${pnpmBuildScript}

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp ${dist}/manifest.json ${dist}/main.js $out/
      [ -f ${dist}/styles.css ] && cp ${dist}/styles.css $out/

      runHook postInstall
    '';
  };
}
