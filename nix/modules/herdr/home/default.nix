/**
Herdr, a multiplexer for coding agents in the terminal, without the first-run
setup and with its plugins installed from Nix, and the settings of its desktop
app.

The terminal multiplexer takes its colours from the terminal, so it follows the
catppuccin theme of Ghostty. The desktop app uses Ghostty's font and its own
catppuccin theme.
*/
{
  config,
  lib,
  perSystem,
  ...
}: {
  imports = [
    ./plugins.nix
    ./app.nix
    ./catppuccin.nix
  ];

  programs.herdr = {
    enable = true;

    settings = {
      onboarding = false;
      theme.name = "terminal";

      keys.command = [
        {
          key = "prefix+e";
          type = "plugin_action";
          command = "chmarax.herdr-nvim.toggle";
          description = "nvim sidebar";
        }
        {
          key = "prefix+o";
          type = "plugin_action";
          command = "chmarax.herdr-nvim.pick-file";
          description = "open file from agent output";
        }
      ];
    };

    plugins = [perSystem.self.herdr-nvim];
  };

  programs.herdr-app = {
    enable = true;

    settings = lib.filterAttrs (_: value: value != null) {
      # Ghostty takes fallback fonts after the first one; the app takes one.
      font = lib.findFirst (_: true) null (lib.toList (config.programs.ghostty.settings.font-family or []));
      font_size = 12;
      font_ligatures = true;
      telemetry = false;
    };
  };
}
