#####################################################
# Yabai window manager configuration for this user. #
#####################################################
{...}: {
  services.yabai = {
    enable = true;

    # Yabai configuration directory.
    configSource = ./config;
  };
}
