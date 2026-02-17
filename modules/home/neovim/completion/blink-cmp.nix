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
          # Keymaps.
          keymap = {
            preset = "default";
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
            "<CR>" = [
              "accept"
              "fallback"
            ];
          };

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
            ghost_text = {
              enabled = true;
            };
            list = {
              selection = {
                preselect = false;
                auto_insert = false;
              };
            };
            menu = {
              border = "rounded";
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window = {
                border = "rounded";
              };
            };
          };
        };
      };
    };
  };
}
