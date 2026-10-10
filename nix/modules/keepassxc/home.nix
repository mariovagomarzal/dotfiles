/**
KeePassXC as the vault for critical credentials, with its SSH agent enabled, so
SSH keys are served from the database instead of files. Closing its window
keeps it in the menu bar.

There is no browser integration: everyday passwords live in the browser's
password manager, and entries here are copied by hand.

The database itself lives outside this repository. Before every save, KeePassXC
copies the previous version to a local folder outside cloud sync. Declaring the
settings makes KeePassXC's configuration file read-only, so it reports an
access error for it at startup; preferences are changed here, not in its
settings window.
*/
{config, ...}: {
  programs.keepassxc = {
    enable = true;
    settings = {
      General = {
        BackupBeforeSave = true;
        BackupFilePathPattern = "${config.xdg.dataHome}/keepassxc/backups/{DB_FILENAME}.kdbx";
      };
      SSHAgent.Enabled = true;
      # Locked when the screen locks or the app quits, not after idle time.
      Security.LockDatabaseIdle = false;
      GUI = {
        ShowTrayIcon = true;
        MinimizeToTray = true;
        MinimizeOnClose = true;
      };
    };
  };
}
