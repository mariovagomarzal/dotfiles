###########################################################
# Default profile for the Visual Studio Code home module. #
###########################################################
{pkgs, ...}: {
  # Disable updates notifications.
  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;

  # Extensions.
  extensions = with pkgs.vscode-extensions; [
    # Language support extensions.
    bbenoist.nix
    ms-python.python
    ms-python.debugpy
    ms-python.vscode-pylance
    julialang.language-julia
    james-yu.latex-workshop
    myriad-dreamin.tinymist
    tamasfe.even-better-toml
    geequlim.godot-tools

    # GitHub copilot.
    github.copilot
    github.copilot-chat

    # Miscellaneous.
    natqe.reload
    adpyke.codesnap
    codezombiech.gitignore
    stkb.rewrap
  ];

  # Settings.
  userSettings = {
    # Suggestions settings.
    "editor.acceptSuggestionOnCommitCharacter" = false;
    "editor.acceptSuggestionOnEnter" = "off";

    # Terminal settings.
    "terminal.integrated.defaultProfile.osx" = "fish";

    # Font settings.
    "editor.fontFamily" = "FiraCode Nerd Font";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 14;

    "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
    "terminal.integrated.fontSize" = 12;

    # Visual settings.
    "editor.mouseWheelZoom" = true;

    "editor.rulers" = [80 100 120];

    "explorer.compactFolders" = false;

    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";

    "editor.minimap.enabled" = true;
    "editor.stickyScroll.enabled" = true;

    "workbench.editor.pinnedTabsOnSeparateRow" = true;
    "workbench.editor.tabSizing" = "shrink";

    # File fomatting settings.
    "files.insertFinalNewline" = true;

    # Extension settings.
    "extensions.autoUpdate" = false;

    # Per-language settings.
    "[markdown]" = {
      "editor.tabSize" = 2;
    };

    "[nix]" = {
      "editor.tabSize" = 2;
    };

    "[latex]" = {
      "editor.tabSize" = 2;
    };
    "[tex]" = {
      "editor.tabSize" = 2;
    };

    "[typst]" = {
      "editor.tabSize" = 2;
    };

    "[shellscript]" = {
      "editor.tabSize" = 2;
    };

    # GitHub Copilot extension settings.
    "github.copilot.enable" = {
      "*" = true;
      "markdown" = true;
      "plaintext" = true;
      "scminput" = false;
    };

    # Rewrap extension settings.
    "rewrap.autoWrap.enabled" = true;
    "rewrap.wrappingColumn" = 80;

    # Tinymist Typst extension settings.

    # LaTeX Workshop extension settings.
    "latex-workshop.latex.autoBuild.run" = "never";
  };

  # Snippets.
  globalSnippets = {};
  languageSnippets = {};

  # Keybindings.
  keybindings = [
    # Accept suggestion with 'shift+enter'.
    {
      key = "shift+enter";
      command = "acceptSelectedSuggestion";
      when = "suggestWidgetVisible";
    }

    # Select next suggestion with 'tab'.
    {
      key = "tab";
      command = "selectNextSuggestion";
      when = "suggestWidgetVisible && suggestWidgetMultipleSuggestions";
    }

    # Disable 'tab' key for accepting suggestion.
    {
      key = "tab";
      command = "-acceptSelectedSuggestion";
    }

    # Accept GitHub copilot suggestion with 'shift+enter'.
    {
      key = "shift+enter";
      command = "editor.action.inlineSuggest.commit";
      when =
        "inlineSuggestionHasIndentationLessThanTabSize && "
        + "inlineSuggestionVisible && "
        + "!suggestWidgetVisible && "
        + "!editorHoverFocused && "
        + "!editorTabMovesFocus";
    }

    # Disable 'tab' key for accepting GitHub copilot suggestion.
    {
      key = "tab";
      command = "-editor.action.inlineSuggest.commit";
    }
  ];

  # Tasks.
  userTasks = {};
}
