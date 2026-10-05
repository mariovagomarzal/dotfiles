{config, ...}: {
  /*
  In this file, we define almost every available option that 'nix-darwin'
  provides to configure system-wide settings/preferences.

  This file is also intended to be used as a reference and/or template for
  other Darwin configurations.
  */
  system = {
    defaults = {
      ActivityMonitor = {
        # Show the application icon in the Dock when running.
        IconType = 0;

        OpenMainWindow = true;

        # Show all processes.
        ShowCategory = 100;

        SortColumn = "CPUUsage";
        SortDirection = 0; # Descending.
      };

      LaunchServices.LSQuarantine = false;

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

      WindowManager = {
        EnableStandardClickToShowDesktop = true;

        StandardHideDesktopIcons = false;

        StandardHideWidgets = false;

        GloballyEnabled = false;

        AppWindowGroupingBehavior = true;

        AutoHide = true;

        EnableTiledWindowMargins = true;

        HideDesktop = true;

        StageManagerHideWidgets = true;
      };

      controlcenter = {
        AirDrop = false;

        BatteryShowPercentage = false;

        Bluetooth = false;

        Display = false;

        FocusModes = true;

        NowPlaying = true;

        Sound = true;
      };

      dock = {
        enable-spring-load-actions-on-all-items = false;

        appswitcher-all-displays = false;

        orientation = "bottom";

        tilesize = 64;

        static-only = false;
        persistent-apps = [
          "/System/Applications/Apps.app"
        ];
        persistent-others = [
          # NOTE: Ideally, the following path should be '~/Downloads', however,
          # thid doesn't work as expected. For the moment, we use the full path
          # to the Downloads folder of the defined primary user.
          "/Users/${config.system.primaryUser}/Downloads"
        ];

        show-recents = false;

        showhidden = true;

        scroll-to-open = true;

        show-process-indicators = true;

        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.5;

        magnification = false;
        largesize = 16;

        launchanim = false;

        mineffect = "genie";

        minimize-to-application = false;

        slow-motion-allowed = false;

        mouse-over-hilite-stack = true;

        mru-spaces = true;

        expose-animation-duration = 0.5;
        expose-group-apps = true;

        wvous-bl-corner = 4; # Show Desktop.
        wvous-br-corner = 2; # Show Mission Control.
        wvous-tr-corner = 12; # Show Notification Center.
        wvous-tl-corner = 1; # Disable.
      };

      finder = {
        AppleShowAllExtensions = true;

        AppleShowAllFiles = true;

        CreateDesktop = true;

        # Set the default search scope to the current folder.
        FXDefaultSearchScope = "SCcf";

        FXEnableExtensionChangeWarning = false;

        # Set the preferred view style to 'Column'.
        FXPreferredViewStyle = "clmv";

        FXRemoveOldTrashItems = false;

        NewWindowTarget = "Home";
        NewWindowTargetPath = null;

        QuitMenuItem = false;

        ShowExternalHardDrivesOnDesktop = true;

        ShowHardDrivesOnDesktop = false;

        ShowMountedServersOnDesktop = true;

        ShowRemovableMediaOnDesktop = true;

        ShowPathbar = true;

        ShowStatusBar = true;

        _FXShowPosixPathInTitle = true;

        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
      };

      hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

      loginwindow = {
        autoLoginUser = "Off";

        DisableConsoleAccess = true;

        GuestEnabled = true;

        SHOWFULLNAME = false;

        LoginwindowText = "";

        ShutDownDisabled = false;

        RestartDisabled = false;

        SleepDisabled = false;

        ShutDownDisabledWhileLoggedIn = false;

        PowerOffDisabledWhileLoggedIn = false;

        RestartDisabledWhileLoggedIn = false;
      };

      magicmouse.MouseButtonMode = "TwoButton";

      menuExtraClock = {
        FlashDateSeparators = false;

        IsAnalog = false;

        Show24Hour = true;
        ShowAMPM = false;

        ShowSeconds = false;

        # Always show the full date.
        ShowDate = 1;
        ShowDayOfMonth = true;
        ShowDayOfWeek = true;
      };

      screencapture = {
        disable-shadow = false;

        show-thumbnail = true;

        location = "~/Desktop";
        target = "file";
        type = "png";

        include-date = true;
      };

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 10;
      };

      spaces.spans-displays = true;

      trackpad = {
        # Disable silent clicking.
        ActuationStrength = 1;

        Clicking = true;

        Dragging = false;

        # Set the click pressure to 'Medium'.
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;

        TrackpadRightClick = true;

        TrackpadThreeFingerDrag = true;

        TrackpadThreeFingerTapGesture = 0;
      };

      universalaccess = {
        closeViewScrollWheelToggle = false;
        closeViewZoomFollowsFocus = false;

        mouseDriverCursorSize = 1.0;

        reduceMotion = false;

        reduceTransparency = false;
      };

      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 2.0;

        "com.apple.sound.beep.sound" = null;
      };

      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;

        AppleScrollerPagingBehavior = true;

        AppleShowScrollBars = "Automatic";

        NSScrollAnimationEnabled = true;

        AppleFontSmoothing = 1;

        AppleICUForce24HourTime = true;

        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = false;

        AppleMetricUnits = 1;
        AppleMeasurementUnits = "Centimeters";
        AppleTemperatureUnit = "Celsius";

        AppleShowAllExtensions = true;

        AppleShowAllFiles = true;

        AppleSpacesSwitchOnActivate = true;

        AppleWindowTabbingMode = "manual";

        AppleKeyboardUIMode = null;

        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2;
        InitialKeyRepeat = 15;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;

        NSAutomaticWindowAnimationsEnabled = true;

        NSDisableAutomaticTermination = true;

        NSDocumentSaveNewDocumentsToCloud = false;

        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;

        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;

        NSTableViewDefaultSizeMode = 3;

        NSTextShowsControlCharacters = true;

        NSUseAnimatedFocusRing = true;

        NSWindowResizeTime = 0.2;

        NSWindowShouldDragOnGesture = false;

        _HIHideMenuBar = false;

        "com.apple.keyboard.fnState" = false;

        "com.apple.mouse.tapBehavior" = 1;

        "com.apple.swipescrolldirection" = true;

        "com.apple.trackpad.enableSecondaryClick" = true;

        "com.apple.trackpad.forceClick" = true;

        "com.apple.trackpad.scaling" = 2.0;

        "com.apple.sound.beep.feedback" = 0;

        "com.apple.sound.beep.volume" = 0.4723665; # Equivalent to 25% volume.

        "com.apple.springing.enabled" = false;
        "com.apple.springing.delay" = 0.0;
      };

      CustomSystemPreferences = {};
      CustomUserPreferences = {};
    };

    keyboard = {
      enableKeyMapping = true;

      nonUS.remapTilde = false;

      remapCapsLockToEscape = true;
      remapCapsLockToControl = false;

      swapLeftCommandAndLeftAlt = false;
      swapLeftCtrlAndFn = false;
    };

    startup.chime = false;
  };

  networking.applicationFirewall = {
    enable = false;
    blockAllIncoming = false;

    allowSigned = true;
    allowSignedApp = true;

    enableStealthMode = true;
  };

  time.timeZone = "Europe/Madrid";

  security.pam.services.sudo_local.touchIdAuth = true;
}
