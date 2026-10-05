#########################################
# Snacks statuscolumn plugin submodule. #
#########################################
_: {
  programs.nixvim = {
    # Snacks statuscolumn.
    plugins.snacks.settings.statuscolumn = {
      enabled = true;

      folds = {
        open = true;
        git_hl = true;
      };
    };
  };
}
