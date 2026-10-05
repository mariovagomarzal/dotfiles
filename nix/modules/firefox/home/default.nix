/**
Firefox with English and Spanish language packs and a default profile with
bookmarks, search engines, extensions and containers.
*/
{...}: {
  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-US"
      "es-ES"
    ];

    # TODO: Check if policies are already working on Darwin.
    policies = {};
  };

  imports = [
    ./default-profile.nix
  ];
}
