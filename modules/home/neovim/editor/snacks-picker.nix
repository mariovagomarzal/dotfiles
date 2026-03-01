###################################
# Snacks picker plugin submodule. #
###################################
{...}: {
  programs.nixvim = {
    # Snacks picker.
    plugins.snacks.settings.picker = {
      enabled = true;
      ui_select = true;
    };

    # Picker keymaps.
    keymaps = [
      # File searching.
      {
        mode = "n";
        key = "<leader>f<space>";
        action = "<cmd>lua Snacks.picker.smart()<CR>";
        options.desc = "Smart find files";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files()<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.smart()<CR>";
        options.desc = "Find text";
      }
      {
        mode = "n";
        key = "<leader>f:";
        action = "<cmd>lua Snacks.picker.commands()<CR>";
        options.desc = "Find commands";
      }
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>lua Snacks.picker.notifications()<CR>";
        options.desc = "Find notifications";
      }

      # Git and GitHub.
      {
        mode = "n";
        key = "<leader>gL";
        action = "<cmd>lua Snacks.picker.git_log()<CR>";
        options.desc = "Find commits";
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>lua Snacks.picker.git_diff()<CR>";
        options.desc = "Find git diff";
      }
      {
        mode = "n";
        key = "<leader>gB";
        action = "<cmd>lua Snacks.picker.git_branches()<CR>";
        options.desc = "Find branches";
      }
      {
        mode = "n";
        key = "<leader>gS";
        action = "<cmd>lua Snacks.picker.git_stash()<CR>";
        options.desc = "Find stashes";
      }
      {
        mode = "n";
        key = "<leader>gi";
        action = "<cmd>lua Snacks.picker.gh_issue()<CR>";
        options.desc = "Find issues";
      }
      {
        mode = "n";
        key = "<leader>gI";
        action = "<cmd>lua Snacks.picker.gh_issue({state = \"all\"})<CR>";
        options.desc = "Find all issues";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>lua Snacks.picker.gh_pr()<CR>";
        options.desc = "Find pull requests";
      }
      {
        mode = "n";
        key = "<leader>gP";
        action = "<cmd>lua Snacks.picker.gh_pr({state = \"all\"})<CR>";
        options.desc = "Find all pull requests";
      }

      # LSP navigation.
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua Snacks.picker.lsp_definitions()<CR>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua Snacks.picker.lsp_declarations()<CR>";
        options.desc = "Go to declaration";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua Snacks.picker.lsp_references()<CR>";
        options.desc = "Go to references";
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>lua Snacks.picker.lsp_implementations()<CR>";
        options.desc = "Go to implementation";
      }
      {
        mode = "n";
        key = "gy";
        action = "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>";
        options.desc = "Go to type definition";
      }
    ];
  };
}
