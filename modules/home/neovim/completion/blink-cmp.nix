#############################################
# Neovim Blink Completion plugin submodule. #
#############################################
{...}: {
  programs.nixvim = {
    plugins = {
      # Blink Completion.
      blink-cmp = {
        enable = true;

        settings = {
          # Sources.
          sources = {
            default = ["lsp" "path" "buffer"];
          };

          # Signature help.
          signature = {
            enabled = true;
            window = {
              border = "rounded";
            };
          };

          # Completion behavior.
          completion = {
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window.border = "rounded";
            };
            menu = {
              auto_show = true;
              border = "rounded";
            };
            ghost_text.enabled = true;
            list.selection = {
              preselect = true;
              auto_insert = false;
            };
          };

          # Keymaps.
          keymap = {
            preset = "none";
            "<S-CR>" = ["accept" "fallback"];
            "<C-CR>" = ["show"];
            "<Tab>" = ["select_next" "fallback"];
            "<S-Tab>" = ["select_prev" "fallback"];
            "<Esc>" = ["hide" "fallback"];
          };
        };
      };
    };
  };
}
