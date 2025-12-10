###############################
# Neovim keymaps home module. #
###############################
{...}: {
  programs.nixvim = {
    # Leader keys.
    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    # Keymaps.
    keymaps = [
      # Save and quit.
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options = {
          desc = "Save file";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options = {
          desc = "Quit current window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>Q";
        action = "<cmd>qa<CR>";
        options = {
          desc = "Quit all windows";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>q!<CR>";
        options = {
          desc = "Quit without saving";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>wq<CR>";
        options = {
          desc = "Save and quit";
          silent = true;
        };
      }

      # Window management and navigation.
      {
        mode = "n";
        key = "<leader>sv";
        action = "<cmd>vsplit<CR>";
        options = {
          desc = "Split window vertically";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>split<CR>";
        options = {
          desc = "Split window horizontally";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sx";
        action = "<cmd>close<CR>";
        options = {
          desc = "Close current split";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Move to left window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Move to window below";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Move to window above";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Move to right window";
          silent = true;
        };
      }

      # Buffer navigation.
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<CR>";
        options = {
          desc = "Go to next buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<CR>";
        options = {
          desc = "Go to previous buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options = {
          desc = "Close the current buffer";
          silent = true;
        };
      }

      # Search.
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options = {
          desc = "Clear search highlights";
          silent = true;
        };
      }

      # Visual mode indenting and lining.
      {
        mode = "v";
        key = ">";
        action = "<gv";
        options = {
          desc = "Indent left and stay in visual mode";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "<";
        action = ">gv";
        options = {
          desc = "Indent right and stay in visual mode";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options = {
          desc = "Move selection down";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options = {
          desc = "Move selection up";
          silent = true;
        };
      }
    ];
  };
}
