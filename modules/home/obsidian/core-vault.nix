############################################
# Core vault for the Obsidian home module. #
############################################
{pkgs, ...}: {
  # Configuration content for the vault.
  settings = {
    # Basic vault settings.
    app = {};

    # Themes and appearance settings.
    themes = [];
    cssSnippets = [];
    appearance = {};

    # Core plugins settings.
    corePlugins = [
      # No-configuration plugins.
      {
        name = "file-explorer";
      }
      {
        name = "global-search";
      }
      {
        name = "graph";
      }
      {
        name = "outgoing-link";
      }
      {
        name = "editor-status";
      }
      {
        name = "bookmarks";
      }
      {
        name = "outline";
      }
      {
        name = "word-count";
      }
      {
        name = "tag-pane";
      }
      {
        name = "properties";
      }
      {
        name = "slash-command";
      }

      # Configurable plugins.
      {
        name = "switcher";
        settings = {
          showExistingOnly = false;
          showAttachments = true;
          showAllFileTypes = false;
        };
      }
      {
        name = "backlink";
        settings = {
          backlinkInDocument = true;
        };
      }
      {
        name = "canvas";
        settings = {
          newFileLocation = "current";
          zoomBreakpoint = 0.5;
        };
      }
      {
        name = "page-preview";
        settings = {
          graph = true;
          bases = true;
          outline = true;
          bookmarks = true;
          file-explorer = true;
          tab-header = true;
          editor = true;
          search = true;
          preview = true;
        };
      }
      {
        name = "daily-notes";
        settings = {
          format = "YYYY-MM-DD";
          folder = "";
          template = "";
        };
      }
      {
        name = "templates";
        settings = {
          folder = "";
          dateFormat = "YYYY-MM-DD";
          timeFormat = "HH:mm";
        };
      }
      {
        name = "note-composer";
        settings = {
          askBeforeMerging = true;
          replacementText = "link";
          template = "";
        };
      }
      {
        name = "command-palette";
        settings = {
          pinned = [];
        };
      }
      {
        name = "file-recovery";
        settings = {
          intervalMinutes = 5;
          keepDays = 7;
        };
      }
      {
        name = "sync";
        settings = {};
      }
    ];

    # Community plugins settings.
    communityPlugins = [];

    # Hotkeys configuration.
    hotkeys = {};

    # Additional files to include in the vault.
    extraFiles = {};
  };
}
