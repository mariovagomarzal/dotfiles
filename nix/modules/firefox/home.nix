/**
Firefox, on every machine, as a secondary browser: its profile is left to
Firefox and Firefox Sync, and only the catppuccin theme is declared.

The theme is applied by catppuccin through Firefox Color, which needs a declared
profile and the extension, installed here by policy. It colours the browser's
interface, not websites.
*/
_: {
  programs.firefox = {
    enable = true;

    policies = {
      DontCheckDefaultBrowser = true;
      ExtensionSettings."FirefoxColor@mozilla.com" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
      };
    };

    # Id 0 makes this the default profile, at the same path it had before.
    profiles.default = {
      id = 0;
      name = "Default";
    };
  };

  # The theme is declared, so it replaces whatever Firefox Color has saved.
  catppuccin.firefox.force = true;
}
