{pkgs, ...}: {
  programs.vscode.profiles.default = {
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance
      julialang.language-julia
      james-yu.latex-workshop
      myriad-dreamin.tinymist
      tamasfe.even-better-toml
      geequlim.godot-tools

      anthropic.claude-code

      natqe.reload
      adpyke.codesnap
      codezombiech.gitignore
      stkb.rewrap
    ];

    userSettings = {
      "editor.acceptSuggestionOnCommitCharacter" = false;
      "editor.acceptSuggestionOnEnter" = "off";

      "terminal.integrated.defaultProfile.osx" = "fish";
      "terminal.integrated.stickyScroll.enabled" = false;
      "terminal.integrated.suggest.enabled" = false;

      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;

      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontSize" = 12;

      "editor.mouseWheelZoom" = true;

      "editor.rulers" = [80 100 120];

      "explorer.compactFolders" = false;

      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";

      "editor.minimap.enabled" = true;
      "editor.stickyScroll.enabled" = true;

      "workbench.editor.pinnedTabsOnSeparateRow" = true;
      "workbench.editor.tabSizing" = "shrink";

      "files.insertFinalNewline" = true;

      "extensions.autoUpdate" = false;

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

      "rewrap.autoWrap.enabled" = true;
      "rewrap.wrappingColumn" = 80;

      "latex-workshop.latex.autoBuild.run" = "never";
    };

    globalSnippets = {};
    languageSnippets = {};

    keybindings = [
      {
        key = "shift+enter";
        command = "acceptSelectedSuggestion";
        when = "suggestWidgetVisible";
      }

      {
        key = "tab";
        command = "selectNextSuggestion";
        when = "suggestWidgetVisible && suggestWidgetMultipleSuggestions";
      }

      {
        key = "tab";
        command = "-acceptSelectedSuggestion";
      }

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

      {
        key = "tab";
        command = "-editor.action.inlineSuggest.commit";
      }
    ];

    userTasks = {};
  };
}
