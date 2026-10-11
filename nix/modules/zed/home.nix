/**
Zed in Vim mode, with extensions for Nix, Lean 4, Typst and LaTeX and the
Nix language servers.
*/
{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    # workaround: external agents in `agent_servers` misbehave when
    # `settings.json` is a read-only link into the Nix store. Remove when they
    # work with `mutableUserSettings = false`.
    mutableUserSettings = true;
    mutableUserKeymaps = false;
    mutableUserTasks = false;
    mutableUserDebug = false;

    extensions = [
      "html"
      "toml"
      "nix"
      "lean4"
      "typst"
      "latex"
    ];

    userSettings = {
      vim_mode = true;
      vim = {
        default_mode = "insert";
        use_system_clipboard = "on_yank";
        toggle_relative_line_numbers = true;
      };

      buffer_font_family = "FiraCode Nerd Font";
      buffer_font_size = 14;

      wrap_guides = [80 100 120];
      cursor_blink = true;
      minimap.show = "auto";

      ensure_final_newline_on_save = true;

      terminal = {
        font_family = "FiraCode Nerd Font";
        font_size = 12;
      };

      project_panel.auto_fold_dirs = false;

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

      languages.Markdown.tab_size = 2;

      languages.LaTeX.tab_size = 2;

      languages.Typst.tab_size = 2;

      languages."Shell Script".tab_size = 2;
    };

    userKeymaps = [];

    userTasks = [];

    userDebug = {};

    enableMcpIntegration = true;

    extraPackages = with pkgs; [
      nixd
      nil
      alejandra
    ];
  };
}
