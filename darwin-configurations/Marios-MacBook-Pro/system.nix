#######################################
# System configuration for this host. #
#######################################
{...}: {
  /*
  In this file, we define almost every available option that 'nix-darwin'
  provides to configure system-wide settings/preferences.

  This file is also intended to be used as a reference and/or template for
  other Darwin configurations.
  */
  system = {
    # Supported version (for 'nix-darwin' compatibility).
    stateVersion = 5;

    # System-wide defaults.
    defaults = {
      # Activity Monitor application settings.
      ActivityMonitor = {
        # Show the application icon in the Dock when running.
        IconType = 0;

        # Open the main window when the application starts.
        OpenMainWindow = true;

        # Show all processes.
        ShowCategory = 100;

        # Sort processes by CPU usage. Order: descending.
        SortColumn = "CPUUsage";
        SortDirection = 0;
      };

      # Disable quarantine for downloaded applications.
      LaunchServices.LSQuarantine = false;

      # Disable automatic updates for macOS.
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

      # Stage Manager (and related) settings.
      WindowManager = {
        # Always show Desktop when clicking on the wallpaper.
        EnableStandardClickToShowDesktop = true;

        # Don't hide Desktop items in normal Desktop mode.
        StandardHideDesktopIcons = false;

        # Don't hide Desktop Widgets in normal Desktop mode.
        StandardHideWidgets = false;

        # Disable Stage Manager.
        GloballyEnabled = false;

        # Set the grouping strategy when showing app windows to 'All at once'.
        AppWindowGroupingBehavior = true;

        # Auto-hide the stage strip.
        AutoHide = true;

        # Enable window margins in Stage Manager.
        EnableTiledWindowMargins = true;

        # Hide Desktop items in Stage Manager.
        HideDesktop = true;

        # Hide Desktop Widgets in Stage Manager.
        StageManagerHideWidgets = true;
      };

      # Control center settings.
      controlcenter = {
        # Don't show the AirDrop control in the menu bar.
        AirDrop = false;

        # Don't show the battery percentage in the menu bar.
        BatteryShowPercentage = false;

        # Don't show the Bluetooth control in the menu bar.
        Bluetooth = false;

        # Don't show the screen brightness control in the menu bar.
        Display = false;

        # Show the Focus control in the menu bar.
        FocusModes = true;

        # Show the 'Now Playing' control in the menu bar.
        NowPlaying = true;

        # Show the sound control in the menu bar.
        Sound = true;
      };

      # Dock (and related) settings.
      dock = {
        # Disable spring-loading for all Dock items.
        enable-spring-load-actions-on-all-items = false;

        # Don't show the appswitcher on all displays.
        appswitcher-all-displays = false;

        # Set the Dock position to the bottom.
        orientation = "bottom";

        # Dock size.
        tilesize = 64;

        # Persistent items in the Dock.
        static-only = false;
        persistent-apps = [
          "/System/Applications/Launchpad.app"
        ];
        persistent-others = [
          "/Users/mariovagomarzal/Downloads"
        ];

        # Don't show recent applications in the Dock.
        show-recents = false;

        # Make the icons of hidden applications translucent in the Dock.
        showhidden = true;

        # Enable 'Scroll to open' for the Dock.
        scroll-to-open = true;

        # Show indicators for open applications in the Dock.
        show-process-indicators = true;

        # Automatically hide and show the Dock.
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.5;

        # Don't magnify the Dock items.
        magnification = false;
        largesize = 16;

        # Don't show opening applications animation in the Dock.
        launchanim = false;

        # Use the 'Genie' effect when minimizing/maximizing windows.
        mineffect = "genie";

        # Don't minimize windows into the application icon.
        minimize-to-application = false;

        # Disable 'Slow Motion' effect when holding Shift key.
        slow-motion-allowed = false;

        # Enable highlight hover effect for the grid view.
        mouse-over-hilite-stack = true;

        # Don't reorder spaces based on most recent use.
        mru-spaces = false;

        # Exposé settings.
        expose-animation-duration = 0.5;
        expose-group-apps = true;

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

        # Show hidden files.
        AppleShowAllFiles = true;

        # Show the icons on the Desktop.
        CreateDesktop = true;

        # Set the default search scope to the current folder.
        FXDefaultSearchScope = "SCcf";

        # Don't show warning before changing an extension.
        FXEnableExtensionChangeWarning = false;

        # Set the preferred view style to 'Column'.
        FXPreferredViewStyle = "clmv";

        # Don't remove old items from the Trash automatically.
        FXRemoveOldTrashItems = false;

        # Set the new Finder window target to the user's home folder.
        NewWindowTarget = "Home";
        NewWindowTargetPath = null;

        # Don't allow quitting Finder.
        QuitMenuItem = false;

        # Show external drives on the Desktop.
        ShowExternalHardDrivesOnDesktop = true;

        # Don't show hard drives on the Desktop.
        ShowHardDrivesOnDesktop = false;

        # Show mounted servers on the Desktop.
        ShowMountedServersOnDesktop = true;

        # Show removable media on the Desktop.
        ShowRemovableMediaOnDesktop = true;

        # Show the path bar.
        ShowPathbar = true;

        # Show the status bar.
        ShowStatusBar = true;

        # Show the full POSIX path in the title bar.
        _FXShowPosixPathInTitle = true;

        # Sort folders first when sorting by name.
        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
      };

      # Behavior of the 'Fn' key. Display the 'Emoji & Symbols' window.
      hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

      # Login window settings.
      loginwindow = {
        # Disable automatic login.
        autoLoginUser = "Off";

        # Disable console access at login window.
        DisableConsoleAccess = true;

        # Enable Guest account.
        GuestEnabled = true;

        # Display a list of users in the login window.
        SHOWFULLNAME = false;

        # Login window text.
        LoginwindowText = "";

        # Show the Shut Down option in the login window.
        ShutDownDisabled = false;

        # Enable the Restart option in the login window.
        RestartDisabled = false;

        # Enable the Sleep option in the login window.
        SleepDisabled = false;

        # Enable the Shut Down menu item while logged in.
        ShutDownDisabledWhileLoggedIn = false;

        # Enable the Power Off menu item while logged in.
        PowerOffDisabledWhileLoggedIn = false;

        # Enable the Restart menu item while logged in.
        RestartDisabledWhileLoggedIn = false;
      };

      # Magic Mouse button mode. Use the 'TwoButton' mode.
      magicmouse.MouseButtonMode = "TwoButton";

      # Menu clock settings.
      menuExtraClock = {
        # Disable flashing time separators.
        FlashDateSeparators = false;

        # Show digital time.
        IsAnalog = false;

        # Use the 24-hour clock.
        Show24Hour = true;
        ShowAMPM = false;

        # Don't show seconds.
        ShowSeconds = false;

        # Always show the full date.
        ShowDate = 1;
        ShowDayOfMonth = true;
        ShowDayOfWeek = true;
      };

      # Screen capture settings.
      screencapture = {
        # Enable shadow in window captures.
        disable-shadow = false;

        # Show the thumbnail of the screenshot.
        show-thumbnail = true;

        # Save screenshots to the Desktop as PNG files.
        location = "/Users/mariovagomarzal/Desktop";
        target = "file";
        type = "png";

        # Include date and time in the file name.
        include-date = true;
      };

      # Screen saver settings.
      screensaver = {
        # Ask for password 10 seconds after screen saver starts.
        askForPassword = true;
        askForPasswordDelay = 10;
      };

      # Displays have separate spaces.
      spaces.spans-displays = false;

      # Trackpad settings.
      trackpad = {
        # Disable silent clicking.
        ActuationStrength = 1;

        # Enable 'Tap to click'.
        Clicking = true;

        # Disable 'Tap to drag'.
        Dragging = false;

        # Set the click pressure to 'Medium'.
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;

        # Enable secondary click.
        TrackpadRightClick = true;

        # Enable 'Three finger drag'.
        TrackpadThreeFingerDrag = true;

        # Disable 'Three finger tap'.
        TrackpadThreeFingerTapGesture = 0;
      };

      # Accessibility settings.
      universalaccess = {
        # Disable scroll gesture with the modifier key to zoom.
        closeViewScrollWheelToggle = false;
        closeViewZoomFollowsFocus = false;

        # Cursor size.
        mouseDriverCursorSize = 1.0;

        # Enable animations when opening windows.
        reduceMotion = false;

        # Enable transparency.
        reduceTransparency = false;
      };

      # Other settings. Note that some of these settings may be redundant.
      ".GlobalPreferences" = {
        # Mouse tracking speed.
        "com.apple.mouse.scaling" = 2.0;

        # Alert sound.
        "com.apple.sound.beep.sound" = null;
      };

      NSGlobalDomain = {
        # Enable swiping with two fingers to navigate backward or forward.
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;

        # Jump to the spot that’s clicked in the scrollbar.
        AppleScrollerPagingBehavior = true;

        # Show the scroll bars automatically.
        AppleShowScrollBars = "Automatic";

        # Enable smooth scrolling.
        NSScrollAnimationEnabled = true;

        # Font smoothing.
        AppleFontSmoothing = 1;

        # Enable the 24-hour clock.
        AppleICUForce24HourTime = true;

        # Set the interface to 'Dark' mode.
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = false;

        # Use the metric system for units.
        AppleMetricUnits = 1;
        AppleMeasurementUnits = "Centimeters";
        AppleTemperatureUnit = "Celsius";

        # Show all file extensions.
        AppleShowAllExtensions = true;

        # Show hidden files.
        AppleShowAllFiles = true;

        # Switch spaces when opening an application.
        AppleSpacesSwitchOnActivate = true;

        # Set the window tabbing mode to 'Manual' when opening a new tab.
        AppleWindowTabbingMode = "manual";

        # Disable full keyboard access.
        AppleKeyboardUIMode = null;

        # Disable the 'Press and Hold' feature.
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
        NSAutomaticInlinePredictionEnabled = false;

        # Animate opening windows and popovers.
        NSAutomaticWindowAnimationsEnabled = true;

        # Disable automatic termination of inactive apps.
        NSDisableAutomaticTermination = true;

        # Don't save documents to iCloud by default.
        NSDocumentSaveNewDocumentsToCloud = false;

        # Use expanded save panel by default.
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;

        # Use the expanded print panel by default.
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;

        # Finde sidebar icons size.
        NSTableViewDefaultSizeMode = 3;

        # Show ASCII control characters in the text using '^' notation.
        NSTextShowsControlCharacters = true;

        # Enable the focus ring animation.
        NSUseAnimatedFocusRing = true;

        # Window resizing speed.
        NSWindowResizeTime = 0.2;

        # Disable the ability to drag windows by clicking anywhere on the
        # window like in Linux.
        NSWindowShouldDragOnGesture = false;

        # Always show the menu bar.
        _HIHideMenuBar = false;

        # Don't use the function keys as standard function keys.
        "com.apple.keyboard.fnState" = false;

        # Enable 'Tap to click' for the trackpad.
        "com.apple.mouse.tapBehavior" = 1;

        # Enable 'Natural' scrolling.
        "com.apple.swipescrolldirection" = true;

        # Enable trackpad secondary click.
        "com.apple.trackpad.enableSecondaryClick" = true;

        # Enable trackpad 'Force Click'.
        "com.apple.trackpad.forceClick" = true;

        # Trackpad tracking speed.
        "com.apple.trackpad.scaling" = 2.0;

        # Don't make a feedback sound when changing the volume.
        "com.apple.sound.beep.feedback" = 0;

        # Alert sound volume.
        "com.apple.sound.beep.volume" = 0.4723665; # Equivalent to 25% volume.

        # Disable spring loading for directories.
        "com.apple.springing.enabled" = false;
        "com.apple.springing.delay" = 0.0;
      };

      # Other settings not covered by 'nix-darwin'.
      CustomSystemPreferences = {};
      CustomUserPreferences = {};
    };

    # Keyboard settings.
    keyboard = {
      # Enable keyboard mapping.
      enableKeyMapping = true;

      # Don't remap tilde on non-US keyboards.
      nonUS.remapTilde = false;

      # Remap Caps Lock to Escape.
      remapCapsLockToEscape = true;
      remapCapsLockToControl = false;

      # Don't swap special keys.
      swapLeftCommandAndLeftAlt = false;
      swapLeftCtrlAndFn = false;
    };

    # Disable startup sound.
    startup.chime = false;
  };

  # Firewall settings.
  networking.applicationFirewall = {
    # Disable the firewall.
    enable = false;
    blockAllIncoming = false;

    # Allow signed applications to receive incoming connections.
    allowSigned = true;
    allowSignedApp = true;

    # Enable stealth mode.
    enableStealthMode = true;
  };

  # Set the timezone to 'Europe/Madrid'.
  time.timeZone = "Europe/Madrid";

  # Allow TouchID to be used for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;
}
