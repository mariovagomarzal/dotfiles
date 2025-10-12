###########################
# SwipeAeroSpace package. #
###########################
{pkgs, ...}:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "SwipeAeroSpace";
  version = "0.2.2";

  src = pkgs.fetchzip {
    url =
      "https://github.com/MediosZ/SwipeAeroSpace/releases/download/"
      + "${finalAttrs.version}/SwipeAeroSpace.zip";
    sha256 = "sha256-gOm1txRezZlnIJsMoAf+gtjGctMdQCHnVnupGmyHwbY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -R ./ $out/Applications/SwipeAerospace.app

    runHook postInstall
  '';
})
