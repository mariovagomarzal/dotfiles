##########################
# Zed module for Darwin. #
##########################
{config, ...}: {
  # On macOS, Zed resolves LSPs from the login shell, not the wrapper's PATH.
  home.packages = config.programs.zed-editor.extraPackages;
}
