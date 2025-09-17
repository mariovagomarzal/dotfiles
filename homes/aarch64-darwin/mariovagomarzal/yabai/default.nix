##########################################
# Yabai home module for mariovagomarzal. #
##########################################
{...}: {
  services.yabai = {
    enable = true;

    # Yabai configuration directory.
    configSource = ./config;
  };
}
