/**
zoxide as a smarter `cd`, with Bash and Fish integration.
*/
_: {
  programs.zoxide = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
