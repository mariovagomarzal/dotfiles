############################
# Claude Code home module. #
############################
{inputs, ...}: let
  marios-claude = path: "${inputs.marios-claude}/claude-code/${path}";
in {
  programs.claude-code = {
    enable = true;
    commandsDir = marios-claude "commands";
  };
}
