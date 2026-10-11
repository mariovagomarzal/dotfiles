/**
Claude Code with a custom status line and no attribution in commits or pull
requests.
*/
_: {
  programs.claude-code = {
    enable = true;

    # Claude Code saves choices such as `/effort` and `/model` to its settings
    # file, so it stays writable; the values declared here are merged into it
    # on every activation.
    mutableSettings = true;

    settings = {
      statusLine = {
        command = ./statusline.py;
        type = "command";
        padding = 0;
      };

      model = "opus";
      thinking.type = "adaptive";

      attribution = {
        commit = "";
        pr = "";
        sessionUrl = false;
      };
    };
  };
}
