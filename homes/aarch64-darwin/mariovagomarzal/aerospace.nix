#########################################
# AeroSpace module for mariovagomarzal. #
#########################################
{...}: {
  programs.aerospace = {
    enable = true;

    # Enable the launchd agent for AeroSpace.
    launchd = {
      enable = true;
      keepAlive = true;
    };

    # AeroSpace configuration content.
    userSettings = {
      # Disable automatic start at login since we use a launchd agent.
      start-at-login = false;
      after-startup-command = [];

      # Exec environment variables.
      exec = {
        inherit-env-vars = true;
        env-vars = {};
      };

      # Allow macOS 'Hide application' (cmd-h) action.
      automatically-unhide-macos-hidden-apps = false;

      # Monitor assignments.
      workspace-to-monitor-force-assignment = {};

      # Normalizations.
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      # Layout settings.
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      # Window paddings.
      accordion-padding = 30;
      gaps = let
        defaultGap = 20;
      in {
        inner.horizontal = defaultGap;
        inner.vertical = defaultGap;
        outer.left = defaultGap;
        outer.bottom = defaultGap;
        outer.top = defaultGap;
        outer.right = defaultGap;
      };

      # Automation hooks.
      exec-on-workspace-change = [];
      on-focus-changed = [];
      on-focused-monitor-changed = [];
      on-window-detected = [
        {
          "if".app-id = "com.valvesoftware.steam";
          run = ["layout floating"];
          check-further-callbacks = true;
        }
      ];

      # Key mapping preset.
      key-mapping.preset = "qwerty";

      # Keybindings by mode.
      # Main mode keybindings.
      mode.main.binding = {
        alt-period = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-tab = "focus-back-and-forth";

        alt-f = "layout floating tiling";

        alt-shift-backspace = "close-all-windows-but-current";

        alt-m = "macos-native-fullscreen";

        ctrl-1 = "workspace 1";
        ctrl-2 = "workspace 2";
        ctrl-3 = "workspace 3";
        ctrl-4 = "workspace 4";
        ctrl-5 = "workspace 5";
        ctrl-6 = "workspace 6";
        ctrl-7 = "workspace 7";
        ctrl-8 = "workspace 8";
        ctrl-9 = "workspace 9";

        # NOTE: This should be 'ctrl-right' and 'ctrl-left', but those conflict
        # with macOS's own workspace switching shortcuts.
        ctrl-shift-right = "workspace next --wrap-around";
        ctrl-shift-left = "workspace prev --wrap-around";

        ctrl-shift-1 = ["move-node-to-workspace 1" "workspace 1"];
        ctrl-shift-2 = ["move-node-to-workspace 2" "workspace 2"];
        ctrl-shift-3 = ["move-node-to-workspace 3" "workspace 3"];
        ctrl-shift-4 = ["move-node-to-workspace 4" "workspace 4"];
        ctrl-shift-5 = ["move-node-to-workspace 5" "workspace 5"];
        ctrl-shift-6 = ["move-node-to-workspace 6" "workspace 6"];
        ctrl-shift-7 = ["move-node-to-workspace 7" "workspace 7"];
        ctrl-shift-8 = ["move-node-to-workspace 8" "workspace 8"];
        ctrl-shift-9 = ["move-node-to-workspace 9" "workspace 9"];

        ctrl-tab = "workspace-back-and-forth";

        alt-enter = "exec-and-forget open -na Alacritty";
        alt-space = "exec-and-forget open -na 'Firefox'";

        cmd-shift-2 = "exec-and-forget screencapture -i -c";

        alt-s = "mode service";
        alt-r = "mode resize";
      };

      # Service mode keybindings.
      mode.service.binding = {
        esc = ["reload-config" "mode main"];

        r = ["flatten-workspace-tree" "mode main"];

        h = ["join-with left" "mode main"];
        j = ["join-with down" "mode main"];
        k = ["join-with up" "mode main"];
        l = ["join-with right" "mode main"];

        down = "volume down";
        up = "volume up";
        shift-down = ["volume set 0" "mode main"];
      };

      # Resize mode keybindings.
      mode.resize.binding = let
        normalStep = "50";
        smallStep = "10";
      in {
        esc = ["reload-config" "mode main"];

        comma = "resize smart +${normalStep}";
        period = "resize smart -${normalStep}";

        shift-comma = "resize smart +${smallStep}";
        shift-period = "resize smart -${smallStep}";

        h = "resize width +${normalStep}";
        l = "resize width -${normalStep}";
        j = "resize height -${normalStep}";
        k = "resize height +${normalStep}";

        shift-h = "resize width +${smallStep}";
        shift-l = "resize width -${smallStep}";
        shift-j = "resize height -${smallStep}";
        shift-k = "resize height +${smallStep}";
      };
    };

    # Enable the SwipeAeroSpace launchd agent.
    swipeaerospace = {
      enable = true;
      keepAlive = true;
    };
  };
}
