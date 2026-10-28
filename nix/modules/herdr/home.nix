/**
Herdr, a multiplexer for coding agents in the terminal, without the first-run
setup.

It takes its colours from the terminal, so it follows the catppuccin theme of
Ghostty.
*/
_: {
  programs.herdr = {
    enable = true;

    settings = {
      onboarding = false;
      theme.name = "terminal";
    };
  };
}
