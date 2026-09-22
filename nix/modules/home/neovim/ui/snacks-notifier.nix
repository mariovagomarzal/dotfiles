#####################################
# Snacks notifier plugin submodule. #
#####################################
{...}: {
  programs.nixvim = {
    # Snacks notifier.
    plugins.snacks.settings.notifier = {
      enabled = true;

      # Notifications timeout (in ms).
      timeout = 3000; # 3 seconds
    };
  };
}
