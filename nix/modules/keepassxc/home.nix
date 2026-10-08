/**
KeePassXC as the password manager, with its Firefox extension and SSH agent
enabled, so SSH keys are served from the database instead of files. Closing
its window keeps it in the menu bar.

The database itself lives outside this repository. Declaring the settings
makes KeePassXC's configuration file read-only, so it reports an access error
for it at startup; preferences are changed here, not in its settings window.
*/
{pkgs, ...}: {
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser.Enabled = true;
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

  programs.firefox.profiles.default.extensions.packages = [
    pkgs.nur.repos.rycee.firefox-addons.keepassxc-browser
  ];
}
