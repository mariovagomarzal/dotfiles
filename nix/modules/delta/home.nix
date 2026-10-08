/**
delta as the pager for Git diffs.
*/
_: {
  programs.delta = {
    enable = true;

    enableGitIntegration = true;
  };
}
