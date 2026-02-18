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

    # Custom autopairs behavior for dollar signs.
    extraConfigLua = ''
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.add_rules({
        -- Auto-pair dollar signs for Typst math delimiters.
        Rule("$", "$", "typst"),

        -- Space expansion: `$|$` -> `$ | $` (inline to display math).
        Rule(" ", " ", "typst")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return pair == "$$"
          end),
      })
    '';
  };
}
