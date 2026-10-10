/**
Homebrew, installed by nix-homebrew from taps pinned in the flake lock, with
the casks, brews and App Store apps that need no configuration.

Desktop apps that integrate with macOS (keychain, Touch ID, permissions, menu
bar, login items) come from Homebrew, signed by their developers, rather than
from Nix. An app that needs any configuration, of its own or of the system,
is installed by its module's `darwin.nix`; the casks listed here need none.
*/
{
  inputs,
  config,
  ...
}: {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;

    user = config.system.primaryUser;

    mutableTaps = false;
    taps = with inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "frankea/homebrew-whisky" = homebrew-whisky;
    };
  };

  homebrew = {
    enable = true;
    caskArgs.appdir = "/Applications";
    onActivation = {
      /*
      Disable `brew update` since taps are immutable and pinned by the flake
      lock, but upgrade installed packages on activation so they follow the
      versions declared by the locked taps.
      */
      autoUpdate = false;
      upgrade = true;

      # Remove all packages managed by Homebrew not listed here.
      cleanup = "zap";
    };

    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [
      "juliaup"

      # Dependencies for the Python libary `manim`.
      "py3cairo"
      "ffmpeg"
      "pkg-config"
      "scipy"

      "pdfpc"
    ];

    casks = [
      "godot"

      "telegram"

      "chatgpt"
      "claude"

      "steam"
      "frankea/whisky/whisky"
      "openemu"

      "skim"
      "maccy"
      "google-drive"
    ];

    masApps = {
      Amphetamine = 937984704;
      "eduVPN client" = 1317704208;
    };
  };
}
