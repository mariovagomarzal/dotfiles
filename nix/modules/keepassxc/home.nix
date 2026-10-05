/**
KeePassXC as the password manager, with its Firefox extension and SSH agent
enabled, so SSH keys are served from the database instead of files. It starts
at login and lives in the menu bar.

The database itself lives outside this repository. Declaring the settings
makes KeePassXC's configuration file read-only, so it reports an access error
for it at startup; preferences are changed here, not in its settings window.
*/
{
  config,
  pkgs,
  ...
}: {
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
        Enabled = true;
        # home-manager installs the native messaging manifest itself.
        UpdateBinaryPath = false;
      };
      SSHAgent.Enabled = true;
      GUI = {
        ShowTrayIcon = true;
        MinimizeToTray = true;
        MinimizeOnClose = true;
      };
    };
  };

  # Opened rather than run, so it is the same app bundle the Dock and Spotlight know.
  launchd.agents.keepassxc = {
    enable = true;
    config = {
      ProgramArguments = ["/usr/bin/open" "-a" "${config.home.homeDirectory}/Applications/Home Manager Apps/KeePassXC.app"];
      RunAtLoad = true;
    };
  };

  programs.firefox.profiles.default.extensions.packages = [
    pkgs.nur.repos.rycee.firefox-addons.keepassxc-browser
  ];
}
