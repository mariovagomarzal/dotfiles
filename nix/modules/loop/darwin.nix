/**
Loop, a window manager driven by a radial menu, with the Fn key freed for its trigger.

Fn opens the emoji picker by default, which Loop's trigger would set off too; the picker stays on Ctrl-Cmd-Space. The
`macos` module sets the base value, so it is overridden here and comes back when Loop is removed.
*/
{lib, ...}: {
  # workaround: Loop keeps its settings in its own preferences, with no file to
  # declare them in, so they are set in the app for now. Declare them here when
  # it can import them from a file (https://github.com/mrkai77/Loop/issues/945).
  homebrew.casks = ["loop"];

  system.defaults.hitoolbox.AppleFnUsageType = lib.mkForce "Do Nothing";
}
