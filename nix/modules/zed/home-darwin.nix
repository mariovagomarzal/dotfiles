/**
Puts Zed's language servers on the user's PATH.

On macOS, Zed resolves language servers from the login shell rather than
from its wrapper's PATH.
*/
{config, ...}: {
  home.packages = config.programs.zed-editor.extraPackages;
}
