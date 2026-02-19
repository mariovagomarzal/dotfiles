########################################
# Neovim project.nvim plugin submodule #
########################################
{...}: {
  programs.nixvim = {
    # Project.nvim.
    plugins.project-nvim = {
      enable = true;

      settings = {
        # Detection methods.
        detection_methods = ["lsp" "pattern"];
        patterns = [
          ".git"
          "Makefile"
          "Justfile"
          "justfile"
          "flake.nix"
          "devenv.nix"
        ];
      };
    };
  };
}
