_: {
  programs.nixvim = {
    plugins.snacks.settings.notifier = {
      enabled = true;

      timeout = 3000; # 3 seconds
    };
  };
}
