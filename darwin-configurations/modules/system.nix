#########################
# System configuration. #
#########################
{...}: {
  system = {
    defaults = {
      # Dock settings.
      dock = {
        # Automatically hide and show the Dock.
        autohide = true;

        # Don't rearrange spaces based on most recent use.
        mru-spaces = false;

        # Hot corners.
        wvous-bl-corner = 4; # Show Desktop.
        wvous-br-corner = 2; # Show Mission Control.
        wvous-tr-corner = 12; # Show Notification Center.
        wvous-tl-corner = 1; # Disable.
      };

      # Finder settings.
      finder = {
        # Show extensions for all files.
        AppleShowAllExtensions = true;

        # Show hidden files.
        AppleShowAllFiles = true;

        # Set the default search scope to the current folder.
        FXDefaultSearchScope = "SCcf";

        # Don't show warning before changing an extension.
        FXEnableExtensionChangeWarning = false;

        # Set the preferred view style to Column.
        FXPreferredViewStyle = "clmv";

        # Show the path bar.
        ShowPathbar = true;

        # Show the status bar.
        ShowStatusBar = true;
      };

      # Menu bar clock settings.
      menuExtraClock = {
        # Display the time in 24-hour format.
        Show24Hour = true;

        # Show the date with the day of the week.
        ShowDate = 0;
        ShowDayOfWeek = true;
      };

      # Screen capture settings.
      screencapture = {
        # Save screenshots to the Desktop.
        location = "~/Desktop";

        # Save screenshots in PNG format.
        type = "png";
      };

      # Screensaver settings.
      screensaver = {
        # Require password after 30 seconds after the screensaver starts.
        askForPassword = true;
        askForPasswordDelay = 30;
      };

      # Trackpad settings.
      trackpad = {
        # Enable tap to click.
        Clicking = true;

        # Enable two-finger secondary click.
        TrackpadRightClick = true;

        # Enable three-finger drag.
        TrackpadThreeFingerDrag = true;
      };

      # Other system defaults not covered by `nix-darwin`.
      NSGlobalDomain = {
        # Keyboard and writing configurations.
        # Disable the press-and-hold character picker.
        ApplePressAndHoldEnabled = false;

        # Use a fast keyboard repeat rate.
        KeyRepeat = 2;
        InitialKeyRepeat = 15;

        # Disable auto-correct and other text substitutions.
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views.
          WebKitDeveloperExtras = true;
        };

        "com.apple.desktopservices" = {
          # Avoid creating `.DS_Store` files on network or USB volumes.
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.WindowManager" = {
          # Enable click on Desktop to show the Desktop.
          EnableStandardClickToShowDesktop = 0;
        };

        # Prevent Photos from opening automatically when devices are plugged in.
        "com.apple.ImageCapture".disableHotPlug = true;
      };
    };

    # Keyboard settings.
    keyboard = {
      # Enable keyboard mapping.
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  # Allow TouchID to be used for sudo.
  security.pam.enableSudoTouchIdAuth = true;
}
