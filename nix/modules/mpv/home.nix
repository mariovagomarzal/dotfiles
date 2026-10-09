/**
mpv as the video player, with its configuration shared by every machine. The
colour scheme comes from the catppuccin module.
*/
_: {
  programs.mpv = {
    enable = true;

    config = {
      save-position-on-quit = true;
      slang = "es,spa,en,eng";
    };
  };
}
