##########################################
# Yabai home module for mariovagomarzal. #
##########################################
{...}: {
  services.yabai = {
    enable = false;

    # Yabai configuration directory.
    configSource = ./config;
  };
}
