####################################
# Neovim lualine plugin submodule. #
####################################
{...}: {
  programs.nixvim = {
    # Lualine.
    plugins.lualine = {
      enable = true;

      settings = {
        # General options.
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

        # Active sections.
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = [
            # Toggleterm: terminal number ([N]) with bold mauve accent.
            {
              __unkeyed-1.__raw = ''
                function()
                  local nr = vim.b.toggle_number or 0
                  return "[" .. nr .. "]"
                end
              '';
              cond.__raw = ''
                function()
                  return vim.bo.filetype == "toggleterm"
                end
              '';
              color = {gui = "bold";};
            }
            # Toggleterm: terminal info (Running <cmd> at <cwd>).
            {
              __unkeyed-1.__raw = ''
                function()
                  local bufname = vim.api.nvim_buf_get_name(0)
                  local cmd = bufname:match("%d+:(.+);#toggleterm")
                  cmd = cmd and vim.fn.fnamemodify(cmd, ":t") or "terminal"
                  local cwd = bufname:match("term://(.-)//")
                  cwd = cwd and vim.fn.fnamemodify(cwd, ":~") or "~"
                  return "Running " .. cmd .. " at " .. cwd
                end
              '';
              cond.__raw = ''
                function()
                  return vim.bo.filetype == "toggleterm"
                end
              '';
            }
            # Regular buffers: filename with relative path.
            {
              __unkeyed-1 = "filename";
              path = 1;
              cond.__raw = ''
                function()
                  return vim.bo.filetype ~= "toggleterm"
                end
              '';
            }
          ];
          lualine_x = ["encoding" "fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };

        # Inactive sections.
        inactive_sections = {
          lualine_c = ["filename"];
          lualine_x = ["location"];
        };

        # Extensions.
        extensions = ["neo-tree"];
      };
    };
  };
}
