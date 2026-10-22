/**
OpenCode, a coding agent for the terminal, with provider and model selection
left to the user.
*/
{
  config,
  lib,
  ...
}: {
  programs.opencode = {
    enable = true;
    mutableSettings = true;
  };

  # workaround: Home Manager and Catppuccin still target OpenCode 1's tui.json.
  # Remove this bridge when they support OpenCode 2's CLI settings
  # (https://github.com/nix-community/home-manager/blob/master/modules/programs/opencode.nix).
  xdg.configFile."opencode/home-manager-tui.json".enable = false;
  home.sessionVariables = lib.mkIf (config.programs.opencode.tui ? theme) {
    OPENCODE_CLI_CONFIG_CONTENT = builtins.toJSON {
      theme.name = config.programs.opencode.tui.theme;
    };
  };
}
