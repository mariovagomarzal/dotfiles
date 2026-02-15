####################################
# Neovim lualine plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    # Lualine.
    plugins = {
      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
            disabled_filetypes.statusline = ["dashboard"];
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = [
              {
                __unkeyed-1 = "filename";
                path = 1;
              }
            ];
            lualine_x = ["encoding" "fileformat" "filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
          inactive_sections = {
            lualine_c = ["filename"];
            lualine_x = ["location"];
          };
          extensions = ["neo-tree"];
        };
      };
    };
  };
}
