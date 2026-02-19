########################
# Typst LSP submodule. #
########################
{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    # Tinymist server.
    lsp.servers.tinymist.enable = true;

    # Conform formatter.
    plugins.conform-nvim.settings = {
      formatters.typststyle.command = lib.getExe pkgs.typstyle;
      formatters_by_ft.typst = ["typststyle"];
    };

    # # Override the default `$` pair to exclude Typst, since dollar
    # # sign pairing is handled via the custom Lua keymaps below.
    # plugins.blink-pairs.settings.mappings.pairs."$" = [
    #   {
    #     __unkeyed_1 = "$";
    #     languages = ["markdown" "markdown_inline" "latex" "plaintex"];
    #   }
    # ];
    #
    # # Dollar sign auto-pairing for Typst.
    # #
    # # Since blink-pairs' `$` pair is disabled for Typst (see
    # # completion/blink-pairs.nix), this handles dollar sign pairing
    # # and space expansion (`$|$` -> `$ | $`) via plain Lua keymaps.
    # # Existing insert-mode handlers (e.g., from blink-pairs) are
    # # saved and chained as fallbacks for <BS> and <Space>.
    # extraConfigLua = ''
    #   do
    #     local function t(str)
    #       return vim.api.nvim_replace_termcodes(str, true, true, true)
    #     end
    #
    #     -- Retrieve an existing insert-mode mapping callback for chaining.
    #     local function get_insert_callback(key)
    #       local map = vim.fn.maparg(key, "i", false, true)
    #       if map and map.callback then
    #         return map.callback, map.expr == 1
    #       end
    #       return nil, false
    #     end
    #
    #     vim.api.nvim_create_autocmd("FileType", {
    #       pattern = "typst",
    #       group = vim.api.nvim_create_augroup("TypstDollarPairs", { clear = true }),
    #       callback = function(args)
    #         local buf = args.buf
    #         local opts = { buffer = buf, expr = true }
    #
    #         -- Save existing handlers before overriding (e.g., from blink-pairs).
    #         local bs_cb, bs_expr = get_insert_callback("<BS>")
    #         local sp_cb, sp_expr = get_insert_callback("<Space>")
    #
    #         local function fallback(cb, is_expr, raw_key)
    #           if cb then
    #             local result = cb()
    #             if is_expr then return result end
    #             return ""
    #           end
    #           return t(raw_key)
    #         end
    #
    #         -- Auto-pair dollar signs.
    #         vim.keymap.set("i", "$", function()
    #           local col = vim.api.nvim_win_get_cursor(0)[2]
    #           local line = vim.api.nvim_get_current_line()
    #           if line:sub(col + 1, col + 1) == "$" then
    #             return t("<Right>")
    #           end
    #           return t("$$<Left>")
    #         end, opts)
    #
    #         -- Space expansion: `$|$` -> `$ | $`.
    #         vim.keymap.set("i", "<Space>", function()
    #           local col = vim.api.nvim_win_get_cursor(0)[2]
    #           local line = vim.api.nvim_get_current_line()
    #           if line:sub(col, col) == "$" and line:sub(col + 1, col + 1) == "$" then
    #             return t("<Space><Space><Left>")
    #           end
    #           return fallback(sp_cb, sp_expr, "<Space>")
    #         end, opts)
    #
    #         -- Backspace: delete dollar pairs (`$$`) or space expansion (`$ | $`).
    #         vim.keymap.set("i", "<BS>", function()
    #           local col = vim.api.nvim_win_get_cursor(0)[2]
    #           local line = vim.api.nvim_get_current_line()
    #
    #           if line:sub(col, col) == "$" and line:sub(col + 1, col + 1) == "$" then
    #             return t("<Right><BS><BS>")
    #           end
    #
    #           if line:sub(col, col) == " " and line:sub(col + 1, col + 1) == " "
    #             and line:sub(col - 1, col - 1) == "$"
    #             and line:sub(col + 2, col + 2) == "$" then
    #             return t("<Right><BS><BS>")
    #           end
    #
    #           return fallback(bs_cb, bs_expr, "<BS>")
    #         end, opts)
    #       end,
    #     })
    #   end
    # '';

    # NOTE: Previous nvim-autopairs implementation (kept for reference).
    # The above plain Lua replaces this, which depended on nvim-autopairs:
    #
    # extraConfigLua = ''
    #   local npairs = require("nvim-autopairs")
    #   local Rule = require("nvim-autopairs.rule")
    #   local cond = require("nvim-autopairs.conds")
    #
    #   npairs.add_rules({
    #     -- Auto-pair dollar signs for Typst math delimiters.
    #     Rule("$", "$", "typst"),
    #
    #     -- Space expansion: `$|$` -> `$ | $` (inline to display math).
    #     Rule(" ", " ", "typst")
    #       :with_pair(function(opts)
    #         local pair = opts.line:sub(opts.col - 1, opts.col)
    #         return pair == "$$"
    #       end)
    #       :with_del(function()
    #         local line = vim.api.nvim_get_current_line()
    #         local col = vim.api.nvim_win_get_cursor(0)[2]
    #         return line:sub(col - 1, col - 1) == "$"
    #            and line:sub(col + 2, col + 2) == "$"
    #       end),
    #   })
    # '';
  };
}
