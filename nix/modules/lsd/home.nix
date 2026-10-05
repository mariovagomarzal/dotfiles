/**
lsd as a replacement for `ls`, in grid layout with directories listed first.
*/
_: {
  programs.lsd = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      layout = "grid";

      sorting = {
        column = "name";
        dir-grouping = "first";
      };
    };
  };
}
