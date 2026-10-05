_: {
  programs.nixvim = {
    plugins.lualine = {
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

        inactive_sections = {
          lualine_c = ["filename"];
          lualine_x = ["location"];
        };

        extensions = ["neo-tree"];
      };
    };
  };
}
