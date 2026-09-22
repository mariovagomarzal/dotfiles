#############################
# Neovim options submodule. #
#############################
{...}: {
  programs.nixvim = {
    # Clipboard integration.
    clipboard.register = "unnamedplus";

    # Options.
    opts = {
      # Mouse.
      mouse = "a";

      # Appearance.
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;

      # Line numbers.
      number = true;
      relativenumber = true;

      # Line wrapping.
      wrap = true;
      linebreak = true;
      breakindent = true;
      showbreak = "↪ ";

      # Column guides.
      colorcolumn = "120";

      # Tabs and indentation.
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;

      # Search behavior.
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # Splits.
      splitright = true;
      splitbelow = true;

      # Backups and undo.
      swapfile = false;
      backup = false;
      undofile = true;

      # Timing.
      timeoutlen = 300;
    };
  };
}
