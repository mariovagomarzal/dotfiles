/**
Codex, OpenAI's coding agent for the terminal, with a status line that shows
the model, project, git branch, context and usage limits.
*/
_: {
  programs.codex = {
    enable = true;

    # Codex saves project trust and interface state to its configuration file,
    # so it stays writable; the values declared here are merged into it on
    # every activation.
    mutableSettings = true;

    settings = {
      model = "gpt-6.1-sol";
      model_reasoning_effort = "high";

      tui.status_line = [
        "model-with-reasoning"
        "project-name"
        "git-branch"
        "context-used"
        "five-hour-limit"
        "weekly-limit"
      ];
    };
  };
}
