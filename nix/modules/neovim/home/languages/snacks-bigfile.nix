_: {
  programs.nixvim = {
    plugins.snacks.settings.bigfile = {
      enabled = true;

      notify = true;

      size = 1.5 * 1024 * 1024;

      line_length = 1000;
    };
  };
}
