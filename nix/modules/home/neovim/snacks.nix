########################################
# Neovim Snacks core plugin submodule. #
########################################
{...}: {
  programs.nixvim = {
    # Snacks.
    # Since Snacks is a colection of various utilities, this module is reserved
    # for enabling the core plugin and configuring global settings. Each
    # utility is configured in its own submodule.
    plugins.snacks = {
      enable = true;
    };
  };
}
