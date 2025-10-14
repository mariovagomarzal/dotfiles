########################
# Firefox home module. #
########################
{...}: {
  programs.firefox = {
    enable = true;

    # Language packs.
    languagePacks = [
      "en-US"
      "es-ES"
    ];

    # Policies.
    # TODO: Check if policies are already working on Darwin.
    policies = {};
  };

  # Imports for profile definitions.
  imports = [
    ./default-profile.nix
  ];
}
