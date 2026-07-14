###########################
# Packages Darwin module. #
###########################
{
  inputs,
  config,
  ...
}: {
  # Homebrew configuration.
  /*
  Some packages are installed via Homebrew because they lack good Nix support on
  macOS. Specifically, GUI applications should be installed this way to ensure
  they appear in the Launchpad and are indexed by Spotlight.
  */
  nix-homebrew = {
    # Install Homebrew under the default prefix and the Intel prefix for Rosetta.
    enable = true;
    enableRosetta = true;

    # User owning the Homebrew prefix.
    user = config.system.primaryUser;

    # Handle taps declaratively only.
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

    # Brew taps to add.
    taps = builtins.attrNames config.nix-homebrew.taps;

    # Brew packages to install, i.e., `brew install <package>`.
    brews = [
      # Programming languages (or related).
      "juliaup"

      # Dependencies for the Python libary `manim`.
      "py3cairo"
      "ffmpeg"
      "pkg-config"
      "scipy"

      # Miscellaneous.
      "pdfpc"
    ];

    # Brew casks to install, i.e., `brew install --cask <package>`.
    casks = [
      # Terminal emulators.
      "alacritty"

      # Text editors (or related).
      "visual-studio-code"
      "zed"
      "godot"

      # Window management.
      "aerospace"
      "swipeaerospace"

      # Web browsers.
      "firefox"
      "google-chrome"

      # Communication tools.
      "discord"
      "telegram"

      # Productivity.
      "obsidian"

      # AI-related tools.
      "chatgpt"
      "claude"

      # Gaming.
      "steam"
      "whisky"
      "openemu"

      # Miscellaneous.
      "calibre"
      "skim"
      "iina"
      "maccy"
      "google-drive"
    ];

    # Applications to install from the Mac App Store.
    masApps = {
      # Miscellaneous.
      Amphetamine = 937984704;
    };
  };
}
