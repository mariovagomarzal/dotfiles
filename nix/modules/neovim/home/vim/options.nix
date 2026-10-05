_: {
  programs.nixvim = {
    clipboard.register = "unnamedplus";

    opts = {
      mouse = "a";

      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;

      number = true;
      relativenumber = true;

      wrap = true;
      linebreak = true;
      breakindent = true;
      showbreak = "↪ ";

      colorcolumn = "120";

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;

      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      splitright = true;
      splitbelow = true;

      swapfile = false;
      backup = false;
      undofile = true;

      timeoutlen = 300;
    };
  };
}
