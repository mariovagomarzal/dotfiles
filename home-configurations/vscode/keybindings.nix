###################################
# Visual Studio Code keybindings. #
###################################
[
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
]
