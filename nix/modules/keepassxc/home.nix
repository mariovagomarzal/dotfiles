/**
KeePassXC as the vault for critical credentials, with its SSH agent enabled, so
SSH keys are served from the database instead of files. Closing its window
keeps it in the menu bar.

There is no browser integration: everyday passwords live in the system's
password manager, and entries here are copied by hand.

The database itself lives outside this repository. Declaring the settings
makes KeePassXC's configuration file read-only, so it reports an access error
for it at startup; preferences are changed here, not in its settings window.
*/
_: {
  programs.keepassxc = {
    enable = true;
    settings = {
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
