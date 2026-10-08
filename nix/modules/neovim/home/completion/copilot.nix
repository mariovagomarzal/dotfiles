_: {
  programs.nixvim = {
    lsp.servers.copilot.enable = true;

    # Disable copilot.lua since is enabled by blink-copilot.
    plugins.copilot-lua.enable = false;

    plugins.blink-copilot.enable = true;

    plugins.blink-cmp.settings.sources = {
      default = ["copilot"];
      providers.copilot = {
        name = "copilot";
        module = "blink-copilot";
        score_offset = 100;
        async = true;
      };
    };
  };
}
