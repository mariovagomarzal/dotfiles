####################################
# Snacks bigfile plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    # Snacks bigfile.
    plugins.snacks.settings.bigfile = {
      enabled = true;

      # Notify when a big file is detected.
      notify = true;

      # File size threshold (in bytes).
      size = 1.5 * 1024 * 1024; # 1.5 MiB

      # Line length threshold.
      line_length = 1000;
    };
  };
}
