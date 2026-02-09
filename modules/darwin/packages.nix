###########################
# Packages Darwin module. #
###########################
{...}: {
  # Packages managed by Homebrew.
  /*
  Some packages are installed via Homebrew because they lack good Nix support on
  macOS. Specifically, GUI applications should be installed this way to ensure
  they appear in the Launchpad and are indexed by Spotlight.
  */
  homebrew = {
    enable = true;
    onActivation = {
      # Disable automatic updates and upgrades.
      autoUpdate = false;
      upgrade = false;

      # Remove all packages managed by Homebrew not listed here.
      cleanup = "zap";
    };

    # Brew taps to add.
    taps = [
      "nikitabobko/tap"
      "mediosz/tap"
    ];

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
