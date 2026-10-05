_: {
  programs.nixvim = {
    plugins.snacks.settings.statuscolumn = {
      enabled = true;

      folds = {
        open = true;
        git_hl = true;
      };
    };
  };
}
