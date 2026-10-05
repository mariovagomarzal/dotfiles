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
