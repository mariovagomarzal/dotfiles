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
          completion = {
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
