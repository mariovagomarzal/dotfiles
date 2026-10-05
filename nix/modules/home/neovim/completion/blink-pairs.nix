_: {
  programs.nixvim = {
    plugins.blink-pairs = {
      enable = true;

      settings = {
        highlights = {
          enabled = true;
          cmdline = true;
          matchparen = {
            enabled = true;
            cmdline = false; # NOTE: Disabled do to a known issue.
            group = "BlinkPairsMatchParen";
            priority = 250;
          };
          groups = [
            "BlinkPairsRed"
            "BlinkPairsYellow"
            "BlinkPairsBlue"
            "BlinkPairsOrange"
            "BlinkPairsGreen"
            "BlinkPairsPurple"
            "BlinkPairsCyan"
          ];
          unmatched_group = "BlinkPairsUnmatched";
        };
      };
    };
  };
}
