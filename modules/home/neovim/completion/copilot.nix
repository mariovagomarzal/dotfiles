####################################
# GitHub Copilot plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    lsp.servers.copilot.enable = true;

    plugins = {
      # Disable copilot.lua since is enabled by blink-copilot.
      copilot-lua.enable = false;

      # Blink-copilot plugin.
      blink-copilot.enable = true;

      # Copilot support for blink.cmp.
      blink-cmp.settings.sources = {
        default = ["copilot"];
        providers.copilot = {
          name = "copilot";
          module = "blink-copilot";
          score_offset = 100;
          async = true;
        };
      };
    };
  };
}
