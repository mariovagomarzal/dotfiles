#######################
# Core shared module. #
#######################
{...}: {
  imports = [];

  # Back up existing files clobbered on activation, overwriting old backups.
  home-manager = {
    backupFileExtension = "backup";
    overwriteBackup = true;
  };
}
