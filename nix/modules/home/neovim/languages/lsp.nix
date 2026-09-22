############################################
# Neovim core LSP configuration submodule. #
############################################
{...}: {
  programs.nixvim = {
    # LSP configuration.
    lsp = {
      # LSP keybindings.
      keymaps = [
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
        }
      ];
    };

    # Use lspconfig for default LSP configurations.
    plugins.lspconfig.enable = true;

    # Diagnostics configuration.
    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      update_in_insert = false;
      underline = true;
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
      };
    };

    # LSP progress notifications.
    extraConfigLuaPre = ''
      -- Track LSP progress per client
      local progress = vim.defaulttable and vim.defaulttable() or setmetatable({}, {
        __index = function(t, k)
          local v = {}
          rawset(t, k, v)
          return v
        end
      })
    '';

    # Show LSP progress with animated spinner using Snacks notifier.
    autoCmd = [
      {
        event = "LspProgress";
        callback.__raw = ''
          function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            local value = ev.data.params.value
            if not client or type(value) ~= "table" then
              return
            end
            local p = progress[client.id]

            for i = 1, #p + 1 do
              if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                  token = ev.data.params.token,
                  msg = ("[%3d%%] %s%s"):format(
                    value.kind == "end" and 100 or value.percentage or 100,
                    value.title or "",
                    value.message and (" **%s**"):format(value.message) or ""
                  ),
                  done = value.kind == "end",
                }
                break
              end
            end

            local msg = {}
            progress[client.id] = vim.tbl_filter(function(v)
              return table.insert(msg, v.msg) or not v.done
            end, p)

            local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            vim.notify(table.concat(msg, "\n"), "info", {
              id = "lsp_progress",
              title = client.name,
              opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
              end,
            })
          end
        '';
      }
    ];

    # Diagnostics keymaps.
    keymaps = [
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options = {
          desc = "Go to previous diagnostic";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options = {
          desc = "Go to next diagnostic";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "gl";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          desc = "Open diagnostic float";
          silent = true;
        };
      }
    ];
  };
}
