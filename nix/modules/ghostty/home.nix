/**
Ghostty terminal with FiraCode Nerd Font and a translucent, blurred window.

The colour scheme comes from the catppuccin module.
*/
_: {
  programs.ghostty = {
    enable = true;

    settings = {
      macos-option-as-alt = "left";
      background-opacity = 0.95;
      background-blur = true;

      window-width = 120;
      window-height = 40;
      window-padding-x = 6;
      window-padding-y = 6;

      font-family = "FiraCode Nerd Font";
      font-size = 12.5;
      font-style-italic = "Light";
      font-style-bold-italic = "Medium";
      font-thicken = true;
      font-thicken-strength = 128;

      cursor-style = "bar";
      cursor-style-blink = true;
    };
  };
}
