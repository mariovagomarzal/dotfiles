############################
# Claude Code home module. #
############################
{pkgs, ...}: let
  inherit (pkgs) fetchFromGitHub;
in {
  programs.claude-code = {
    enable = true;

    # Extra marketplaces.
    marketplaces = {
      "leanprover" = fetchFromGitHub {
        owner = "leanprover";
        repo = "skills";
        rev = "7d3da0282e7b724b07620e45cf212f2e05e19334";
        sha256 = "sha256-wMGIyEwwM+R5B6pGtP/jsaA8KN2CDCE2SbNZ4b+REgk=";
      };
    };

    # Claude Code configuration content.
    settings = {
      # Status line configuration.
      statusLine = {
        command = ./statusline.py;
        type = "command";
        padding = 0;
      };

      # Model configuration.
      model = "opus";
      alwaysThinkEnabled = true;

      # Commit message attributions.
      attribution = {
        commit = "";
        pr = "";
      };

      # Enabled plugins.
      enabledPlugins = {
        "lean@leanprover" = true;
      };
    };

    # The directory where custom commands are stores.
    commandsDir = ./commands;
  };
}
