/**
Homebrew, installed by nix-homebrew from taps pinned in the flake lock, with
the casks, brews and App Store apps that Nix does not cover well.

GUI applications in particular go through Homebrew so that they appear in
Launchpad and are indexed by Spotlight.
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
    };
  };

  homebrew = {
    enable = true;
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
      "alacritty"

      "visual-studio-code"
      "godot"

      "aerospace"
      "swipeaerospace"

      "firefox"
      "google-chrome"

      "discord"
      "telegram"

      "obsidian"

      "chatgpt"
      "claude"

      "steam"
      "whisky"
      "openemu"

      "calibre"
      "skim"
      "iina"
      "maccy"
      "google-drive"
    ];

    masApps = {
      Amphetamine = 937984704;
    };
  };
}
