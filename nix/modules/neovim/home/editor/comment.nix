_: {
  programs.nixvim = {
    plugins.comment = {
      enable = true;

      settings = {
        padding = true;
        sticky = true;
      };
    };
  };
}
