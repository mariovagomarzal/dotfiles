#####################################################
# Yabai window manager configuration for this user. #
#####################################################
{pkgs, ...}: {
  home.packages = [pkgs.yabai];

  home.file.yabairc = {
    text = ''
      # Layout
      yabai -m config layout bsp
      yabai -m config --space 1 layout float

      # Padding and gaps
      yabai -m config top_padding    20
      yabai -m config bottom_padding 20
      yabai -m config left_padding   20
      yabai -m config right_padding  20
      yabai -m config window_gap     20

      # Mouse support
      yabai -m config mouse_modifier ctrl
      yabai -m config mouse_action1 move
      yabai -m config mouse_action2 resize

      yabai -m config mouse_follows_focus on
    '';
    executable = true;
    target = ".config/yabai/yabairc";
    # onChange = "yabai --restart-service";
  };
}
