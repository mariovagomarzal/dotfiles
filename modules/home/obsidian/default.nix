#########################
# Obsidian home module. #
#########################
{...}: {
  programs.obsidian = {
    enable = true;

    # Default settings applied to all vaults if not overridden in the vault
    # definition.
    defaultSettings = {
    };
  };

  # Imports for vault definitions.
  imports = [
    ./core-vault.nix
  ];
}
