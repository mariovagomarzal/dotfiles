#######################
# Skhd hotkey daemon. #
#######################
{pkgs, ...}: {
  home.packages = [pkgs.skhd];

  home.file.skhdrc = {
    text = ''
      cmd - return : open -n /Applications/Alacritty.app/
      cmd + shift - backspace : yabai -m window --focus prev\
                             && yabai -m window --close

      ctrl - f : yabai -m space --mirror y-axis
      ctrl + shift - return : yabai -m window --warp first

      ctrl - j : yabai -m window --focus next
      ctrl - k : yabai -m window --focus prev

      # Fix for the Logitech Options+ app.
      cmd + shift - l : kill -9 $(ps aux | grep "MacOS/logioptionsplus_agent" | grep -v grep | awk '{print $2}')
    '';
    executable = true;
    target = ".config/skhd/skhdrc";
    # onChange = "skhd --restart-service";
  };
}
