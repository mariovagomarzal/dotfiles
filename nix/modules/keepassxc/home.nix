/**
KeePassXC as the password manager, with its Firefox extension and SSH agent
enabled, so SSH keys are served from the database instead of files.

The database itself lives outside this repository. Declaring the settings
makes KeePassXC's configuration file read-only, so it reports an access error
for it at startup; preferences are changed here, not in its settings window.
*/
{pkgs, ...}: {
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
        Enabled = true;
        # home-manager installs the native messaging manifest itself.
        UpdateBinaryPath = false;
      };
      SSHAgent.Enabled = true;
    };
  };

  programs.firefox.profiles.default.extensions.packages = [
    pkgs.nur.repos.rycee.firefox-addons.keepassxc-browser
  ];
}
