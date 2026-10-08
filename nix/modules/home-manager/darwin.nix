/**
home-manager integration settings for nix-darwin.

Files that would be overwritten on activation are kept with a `.backup`
extension, replacing older backups.
*/
_: {
  home-manager = {
    backupFileExtension = "backup";
    overwriteBackup = true;
  };
}
