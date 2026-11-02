/**
herdr-core (`hc`), the server that runs the terminals and agents of the Herdr
desktop app and keeps them alive when its window closes.

The app looks for it on the login shell's PATH and offers to install the
release build into `~/.local/bin` when it finds none. Built here, it is
updated with the rest of the configuration: `hc update` recognises a core
installed by Nix and leaves it alone.

Based on the nixpkgs packaging of `herdr`, which builds the same terminal
core (libghostty-vt) through Zig, and on the Linux packaging in
<https://github.com/TamagoMasgend/herdr-app-nix>.
*/
{pkgs, ...}: let
  inherit (pkgs) lib stdenv;
  zig = pkgs.zig_0_16;
in
  # workaround: herdr-core is not in nixpkgs, so it is packaged here. Remove
  # when nixpkgs has `herdr-core` (https://github.com/herdrdev/herdr-core).
  pkgs.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "herdr-core";
    version = "0.1.17";

    __structuredAttrs = true;

    src = pkgs.fetchFromGitHub {
      owner = "herdrdev";
      repo = "herdr-core";
      tag = "v${finalAttrs.version}";
      fetchSubmodules = true;
      hash = "sha256-fulACGl26Pk6FAvOOJsFtPfFQMwJAfw/MqMa6Rq0/4c=";
    };

    cargoHash = "sha256-UZsc5AElm5gmIImgR8cZz0U9+2RNG+DRb+OU8ifZSXc=";

    # libghostty-vt fetches its Zig packages while building; this is that
    # download, pinned.
    zigDeps = zig.fetchDeps {
      inherit (finalAttrs) pname version;
      src = "${finalAttrs.src}/vendor/ghostty";
      fetchAll = true;
      hash = "sha256-G9xbZ/pyQTDIfzG0h++i70a45zpwyYpZMBZfAnoOQw0=";
    };

    nativeBuildInputs =
      [zig]
      ++ lib.optionals stdenv.hostPlatform.isDarwin [
        pkgs.cctools
        pkgs.xcbuild
      ];

    # Cargo drives Zig through the ghostty-vt build script.
    dontUseZigBuild = true;
    dontUseZigCheck = true;
    dontUseZigInstall = true;

    postPatch =
      ''
        # To set up another machine with the same OS and CPU, hc copies its own
        # binary there, which loads its libraries from /nix/store. Every
        # machine gets the statically linked release build instead.
        substituteInPlace crates/herdr-core/src/machines.rs \
          --replace-fail 'let exe = if there == here {' 'let exe = if false {'
      ''
      + lib.optionalString stdenv.hostPlatform.isDarwin ''
        # Only the static archive is linked; the xcframework needs Apple's
        # xcodebuild, which nixpkgs lacks. herdr builds it the same way.
        substituteInPlace crates/ghostty-vt/build.rs \
          --replace-fail '"-Dcpu=baseline"]' '"-Dcpu=baseline", "-Demit-xcframework=false"]'

        substituteInPlace vendor/ghostty/pkg/apple-sdk/native_link.zig \
          --replace-fail '"/usr/bin/xcrun"' '"xcrun"'

        substituteInPlace vendor/ghostty/src/build/GhosttyLibVt.zig \
          --replace-fail '"/bin/ln"' '"ln"'

        substituteInPlace vendor/ghostty/src/build/LibtoolStep.zig \
          --replace-fail '/bin/cp ' 'cp ' \
          --replace-fail '/usr/bin/ranlib ' 'ranlib '
      '';

    preBuild = ''
      export ZIG_GLOBAL_CACHE_DIR=$(mktemp -d)
      cp -rL ${finalAttrs.zigDeps} "$ZIG_GLOBAL_CACHE_DIR/p"
      chmod -R u+w "$ZIG_GLOBAL_CACHE_DIR/p"
    '';

    # The tests set up remote machines over a fake ssh and need paths the
    # build sandbox lacks.
    doCheck = false;

    postInstall = ''
      ln -s herdr-core $out/bin/hc
    '';

    meta = {
      description = "Terminals for coding agents that keep running after you leave";
      homepage = "https://github.com/herdrdev/herdr-core";
      license = lib.licenses.asl20;
      mainProgram = "hc";
      platforms = lib.platforms.unix;
    };
  })
