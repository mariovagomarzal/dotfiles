####################
# Zed home module. #
####################
{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    # Disable mutable configurations for Zed.
    # TODO: `mutableUserSettings` is `true` temporarily. With a read-only
    # `settings.json` (symlink to `/nix/store`) `agent_servers` doesen't seem
    # to work properly.
    mutableUserSettings = true;
    mutableUserKeymaps = false;
    mutableUserTasks = false;
    mutableUserDebug = false;

    # Extensions.
    extensions = [
      "html"
      "toml"
      "nix"
      "lean4"
      "typst"
      "latex"
    ];

    # General settings.
    userSettings = {
      # Use Vim mode.
      vim_mode = true;
      vim = {
        default_mode = "insert";
        use_system_clipboard = "on_yank";
        toggle_relative_line_numbers = true;
      };

      # Font settings.
      buffer_font_family = "FiraCode Nerd Font";
      buffer_font_size = 14;

      # Visual settings.
      wrap_guides = [80 100 120];
      cursor_blink = true;
      minimap.show = "auto";

      # File formatting settings.
      ensure_final_newline_on_save = true;

      # Terminal settings.
      terminal = {
        font_family = "FiraCode Nerd Font";
        font_size = 12;
      };

      # Project panel settings.
      project_panel.auto_fold_dirs = false;

      # Nix language settings.
      languages.Nix = {
        tab_size = 2;
        language_servers = [
          "nil"
          "!nixd"
        ];
      };
      lsp.nil = {
        initialization_options = {
          formatting.command = [
            "alejandra"
            "--quiet"
            "--"
          ];
        };
      };

      # Markdown language settings.
      languages.Markdown.tab_size = 2;

      # LaTeX language settings.
      languages.LaTeX.tab_size = 2;

      # Typst language settings.
      languages.Typst.tab_size = 2;

      # Shell Script language settings.
      languages."Shell Script".tab_size = 2;
    };

    # Keymaps.
    userKeymaps = [];

    # Tasks.
    userTasks = [];

    # Debug configurations.
    userDebug = {};

    # Enable home-manager MCP integration for Zed.
    enableMcpIntegration = true;

    # Extra packages.
    extraPackages = with pkgs; [
      nixd
      nil
      alejandra
    ];
  };
}
