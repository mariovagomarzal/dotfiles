#########################
# System-wide packages. #
#########################
{pkgs, ...}: {
  # Shell configuration.
  # Enable the fish shell and add it to the list of available shells.
  programs.fish.enable = true;
  environment.shells = [pkgs.fish];

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
    pyenv
    julia-bin
    elan
    typst
    texliveFull
    rustup
    zulu

    # Miscellaneous.
    aria2
  ];

  # Fonts.
  fonts = {
    packages = with pkgs; [
      # Nerdfonts.
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  # Packages managed by Homebrew.
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
      "homebrew/cask-fonts"
      "homebrew/services"
    ];

    # Brew packages to install, i.e., `brew install <package>`.
    brews = [
      "juliaup"
      "pdfpc"

      # Dependencies for the Python libary `manim`.
      "py3cairo"
      "ffmpeg"
      "pkg-config"
      "scipy"
    ];

    # Brew casks to install, i.e., `brew install --cask <package>`.
    casks = [
      "google-chrome"
      "alacritty"
      "visual-studio-code"
      "logi-options+"
      "skim"
      "calibre"
      "google-drive"
      "iina"
      "maccy"
      "steam"
      "openemu"
      "godot"
    ];

    # Applications to install from the Mac App Store.
    masApps = {
      Amphetamine = 937984704;
    };
  };

  # Environment variables (related to the packages managed here).
  environment.variables = {
    SHELL = "/run/current-system/sw/bin/fish";
    EDITOR = "vim";
  };
}
