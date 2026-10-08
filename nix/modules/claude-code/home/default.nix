/**
Claude Code with a custom status line, personal slash commands and the Lean
plugin from the leanprover marketplace.
*/
{pkgs, ...}: let
  inherit (pkgs) fetchFromGitHub;
in {
  programs.claude-code = {
    enable = true;

    marketplaces = {
      "leanprover" = fetchFromGitHub {
        owner = "leanprover";
        repo = "skills";
        rev = "7d3da0282e7b724b07620e45cf212f2e05e19334";
        sha256 = "sha256-wMGIyEwwM+R5B6pGtP/jsaA8KN2CDCE2SbNZ4b+REgk=";
      };
    };

    settings = {
      statusLine = {
        command = ./statusline.py;
        type = "command";
        padding = 0;
      };

      model = "opus";
      thinking.type = "adaptive";

      attribution = {
        commit = "";
        pr = "";
      };

      enabledPlugins = {
        "lean@leanprover" = true;
      };
    };

    commandsDir = ./commands;
  };
}
