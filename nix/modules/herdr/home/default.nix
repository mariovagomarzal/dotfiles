/**
Herdr, a multiplexer for coding agents in the terminal, without the first-run
setup, and its desktop app with its settings.

The desktop app runs its terminals in herdr-core, which nixpkgs builds into it.

The terminal multiplexer takes its colours from the terminal, so it follows the
catppuccin theme of Ghostty. The desktop app uses Ghostty's font and its own
catppuccin theme.
*/
{
  config,
  lib,
  ...
}: {
  imports = [
    ./app.nix
    ./catppuccin.nix
  ];

  programs.herdr = {
    enable = true;

    settings = {
      onboarding = false;
      theme.name = "terminal";
    };
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
