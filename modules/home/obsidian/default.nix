#########################
# Obsidian home module. #
#########################
{perSystem, ...}: let
  # Auxiliary function to import a vault definition.
  importVault = name: file: args:
    {target = "Obsidian/${name}";}
    // (import file args);
in {
  programs.obsidian = {
    enable = true;

    # Default settings applied to all vaults if not overridden in the vault
    # definition.
    defaultSettings = {
    };

    # Vaults.
    vaults = {
      # Core vault.
      core = importVault "Core" ./core-vault.nix {
        inherit perSystem;
      };
    };
  };
}
