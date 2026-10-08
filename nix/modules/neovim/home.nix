/**
Neovim as a light terminal editor for occasional edits: syntax highlighting,
a file picker and explorer from mini.nvim, and a few leader mappings. The
colour scheme comes from the catppuccin module.

Code editing happens in Zed, so there is no LSP, completion or formatting.
*/
{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;

    plugins = with pkgs.vimPlugins; [
      mini-nvim
      (nvim-treesitter.withPlugins (grammars:
        with grammars; [
          bash
          diff
          fish
          git_rebase
          gitcommit
          go
          json
          lua
          markdown
          markdown_inline
          nix
          python
          toml
          yaml
        ]))
    ];

    initLua = ''
      vim.g.mapleader = " "

      local opt = vim.opt
      opt.clipboard = "unnamedplus"
      opt.mouse = "a"
      opt.number = true
      opt.relativenumber = true
      opt.signcolumn = "yes"
      opt.cursorline = true
      opt.scrolloff = 8
      opt.sidescrolloff = 8
      opt.wrap = true
      opt.linebreak = true
      opt.breakindent = true
      opt.showbreak = "↪ "
      opt.tabstop = 4
      opt.shiftwidth = 4
      opt.expandtab = true
      opt.ignorecase = true
      opt.smartcase = true
      opt.splitright = true
      opt.splitbelow = true
      opt.swapfile = false
      opt.undofile = true
      opt.timeoutlen = 300

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })

      require("mini.icons").setup()
      require("mini.statusline").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.diff").setup()
      require("mini.files").setup()
      require("mini.pick").setup()

      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          { mode = "n", keys = "g" },
          { mode = "n", keys = "<C-w>" },
        },
        clues = {
          miniclue.gen_clues.g(),
          miniclue.gen_clues.windows(),
        },
      })

      local map = vim.keymap.set
      map("n", "<Leader>w", "<Cmd>write<CR>", { desc = "Save file" })
      map("n", "<Leader>q", "<Cmd>quit<CR>", { desc = "Quit window" })
      map("n", "<Leader>Q", "<Cmd>quitall<CR>", { desc = "Quit all" })
      map("n", "<Leader>x", "<Cmd>xit<CR>", { desc = "Save and quit" })
      map("n", "<Leader>ff", "<Cmd>Pick files<CR>", { desc = "Find files" })
      map("n", "<Leader>fg", "<Cmd>Pick grep_live<CR>", { desc = "Search text" })
      map("n", "<Leader>fb", "<Cmd>Pick buffers<CR>", { desc = "Find buffers" })
      map("n", "<Leader>e", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = "Explorer" })
      map("n", "<Esc>", "<Cmd>nohlsearch<CR>")
      map("x", "<", "<gv")
      map("x", ">", ">gv")
      for key, dir in pairs({ h = "h", j = "j", k = "k", l = "l" }) do
        map("n", "<A-" .. key .. ">", "<C-w>" .. dir)
      end
    '';
  };
}
