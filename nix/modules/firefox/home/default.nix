/**
Firefox with a default profile of bookmarks, search engines, extensions and
containers.
*/
{...}: {
  programs.firefox.enable = true;

  imports = [
    ./default-profile.nix
  ];
}
