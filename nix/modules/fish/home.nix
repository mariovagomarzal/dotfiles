/**
Fish as the interactive shell, with a custom greeting, also opened by Ghostty.

home-manager cannot change the login shell, so Ghostty starts Fish itself on machines managed by home-manager alone.
*/
{
  config,
  lib,
  ...
}: {
  programs.ghostty.settings.command = "${lib.getExe config.programs.fish.package} -l";

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
