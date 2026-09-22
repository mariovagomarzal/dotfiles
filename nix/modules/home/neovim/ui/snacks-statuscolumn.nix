#########################################
# Snacks statuscolumn plugin submodule. #
#########################################
{...}: {
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
