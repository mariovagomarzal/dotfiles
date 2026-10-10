/**
mpv as the video player, with its configuration shared by every machine.

The catppuccin theme is left off: it paints the letterbox bars around the video
in the theme's background colour instead of black.
*/
_: {
  programs.mpv = {
    enable = true;

    config = {
      save-position-on-quit = true;
      slang = "es,spa,en,eng";
    };
  };

  catppuccin.mpv.enable = false;
}
