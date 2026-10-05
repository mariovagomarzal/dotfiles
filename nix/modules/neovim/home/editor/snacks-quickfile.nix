_: {
  programs.nixvim = {
    plugins.snacks.settings.quickfile = {
      enabled = true;

      exclude = ["latex"];
    };
  };
}
