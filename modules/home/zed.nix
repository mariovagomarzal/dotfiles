####################
# Zed home module. #
####################
{...}: {
  programs.zed-editor = {
    enable = true;

    # Disable mutable configurations for Zed.
    mutableUserSettings = false;
    mutableUserKeymaps = false;
    mutableUserTasks = false;
    mutableUserDebug = false;

    # Extensions.
    extensions = [];

    # Enable home-manager MCP integration for Zed.
    enableMcpIntegration = true;

    # General settings.
    userSettings = {};

    # Keymaps.
    userKeymaps = {};

    # Tasks.
    userTasks = {};

    # Debug configurations.
    userDebug = {};
  };
}
