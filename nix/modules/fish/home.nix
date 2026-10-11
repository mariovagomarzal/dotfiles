/**
Fish as the interactive shell, with a custom greeting, also opened by Alacritty.

home-manager cannot change the login shell, so Alacritty starts Fish itself on machines managed by home-manager alone.
*/
{
  config,
  lib,
  ...
}: {
  programs.alacritty.settings.terminal.shell = {
    program = lib.getExe config.programs.fish.package;
    args = ["-l"];
  };

  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = ''
        echo "Welcome, $(set_color green; echo -n $USER; set_color normal)! This is fish shell."
        echo ""
      '';
    };
  };
}
