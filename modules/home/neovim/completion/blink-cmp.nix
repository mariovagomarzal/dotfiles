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
          sources = {
            default = ["lsp" "path" "buffer"];
          };
          signature = {
            enabled = true;
            window = {
              border = "rounded";
            };
          };
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
