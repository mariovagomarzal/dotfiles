/**
Firefox with a default profile of bookmarks, search engines, uBlock Origin and
containers.

The catppuccin theme is left off, so the browser and websites keep their own
look.
*/
{...}: {
  programs.firefox.enable = true;

  catppuccin.firefox.enable = false;

  imports = [
    ./default-profile.nix
  ];
}
