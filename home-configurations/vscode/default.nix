#####################################
# Visual Studio Code configuration. #
#####################################
{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    # Disable updates notifications.
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    # Extensions.
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      # Language support extensions.
      bbenoist.nix
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance
      julialang.language-julia
      james-yu.latex-workshop
      nvarner.typst-lsp

      # GitHub copilot.
      github.copilot
      github.copilot-chat

      # Themes and icons.
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # Miscellaneous.
      adpyke.codesnap
      codezombiech.gitignore
      stkb.rewrap
    ];

    # Snippets.
    globalSnippets = import ./global-snippets.nix;
    languageSnippets = import ./language-snippets.nix;

    # Keybindings.
    keybindings = import ./keybindings.nix;

    # Settings.
    userSettings = import ./user-settings.nix;

    # Tasks.
    userTasks = import ./user-tasks.nix;
  };
}
