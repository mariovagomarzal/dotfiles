###########################################
# Builder for npm-based Obsidian plugins. #
###########################################
{
  lib,
  buildNpmPackage,
}:
lib.extendMkDerivation {
  constructDrv = buildNpmPackage;

  extendDrvArgs = _: {dist ? "dist", ...}: {
    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp ${dist}/manifest.json ${dist}/main.js $out/
      [ -f ${dist}/styles.css ] && cp ${dist}/styles.css $out/

      runHook postInstall
    '';
  };
}
