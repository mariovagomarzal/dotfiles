#####################################
# Visual Studio Code user settings. #
#####################################
{
  # Suggestions settings.
  "editor.acceptSuggestionOnCommitCharacter" = false;
  "editor.acceptSuggestionOnEnter" = "off";

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
}
