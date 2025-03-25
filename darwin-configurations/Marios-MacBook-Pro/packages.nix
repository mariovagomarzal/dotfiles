#######################################
# System-wide packages for this host. #
#######################################
{
  pkgs,
  config,
  ...
}: let
  # The 'fish' package used in the configuration.
  fish = config.programs.fish.package;
in {
  # Shell configuration.
  # Enable the fish shell and add it to the list of available shells. Also, set
  # the default shell to fish by setting the `SHELL` environment variable.
  programs.fish.enable = true;
  environment.shells = [fish];
  environment.variables.SHELL = "/run/current-system/sw${fish.shellPath}";

  # Other packages that should be available system-wide.
  environment.systemPackages = with pkgs; [
    # Core tools.
    git
    gnupg
    just

    # Text editors.
    vim

    # Programming languages (or related).
    python312

    # Miscellaneous.
    aria2
  ];

  # Fonts.
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # Packages managed by Homebrew.
  # Some packages are installed via Homebrew because they lack good Nix support
  # on macOS. Specifically, GUI applications should be installed this way to
  # ensure they appear in the Launchpad and are indexed by Spotlight.
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
    taps = [];

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

      # Web browsers.
      "firefox"
      "google-chrome"

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
      "logi-options+"
    ];

    # Applications to install from the Mac App Store.
    masApps = {
      # Miscellaneous.
      Amphetamine = 937984704;
    };
  };

  # Environment variables (related to the packages managed here).
  environment.variables = {
    EDITOR = "vim";
  };
}
