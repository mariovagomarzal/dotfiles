############################################
# Core vault for the Obsidian home module. #
############################################
{perSystem, ...}: {
  programs.obsidian.vaults.core = {
    target = "Obsidian/Core";

    # Configuration content for the vault.
    settings = {
      # Basic vault settings.
      app = {
        focusNewTab = true;
        defaultViewMode = "preview";
        livePreview = false;
        readableLineLength = true;
        strictLineBreaks = false;
        propertiesInDocument = "visible";
        foldHeading = true;
        foldIndent = true;
        showLineNumber = false;
        showIndentGuide = true;
        rightToLeft = false;
        spellcheck = true;
        autoPairBrackets = true;
        autoPairMarkdown = true;
        smartIndentList = true;
        useTab = true;
        tabSize = 2;
        autoConvertHtml = true;
        vimMode = false;
        promptDelete = false;
        trashOption = "local";
        alwaysUpdateLinks = false;
        newFileLocation = "current";
        newLinkFormat = "shortest";
        useMarkdownLinks = false;
        showUnsupportedFiles = true;
        attachmentFolderPath = "98 - Recursos";
        userIgnoreFilters = [];
        uriCallbacks = false;
      };

      # Themes and appearance settings.
      themes = [
        {
          pkg = perSystem.self.obsidian-catppuccin;
          enable = true;
        }
      ];
      cssSnippets = [];
      appearance = {
        theme = "obsidian"; # Equivalent to dark mode.
        baseFontSize = 16;
        baseFontSizeAction = true;
        textFontFamily = "NewComputerModern10";
        monospaceFontFamily = "FiraCode Nerd Font Mono";
        showViewHeader = true;
        showRibbon = true;
        nativeMenus = false;
        translucency = true;
      };

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
            folder = "01 - Personal/Diario";
            template = "99 - Meta/Plantillas/Nota diaria";
          };
        }
        {
          name = "templates";
          settings = {
            folder = "99 - Meta/Plantillas";
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
      communityPlugins = [
        {
          pkg = perSystem.self.obsidian-style-settings;
          settings = {};
        }
        {
          pkg = perSystem.self.advanced-tables-obsidian;
          settings = {};
        }
        {
          pkg = perSystem.self.obsidian-latex-suite;
          settings = {};
        }
        {
          pkg = perSystem.self.obsidian-mathjax-preamble-manager;
          settings = {};
        }
      ];

      # Hotkeys configuration.
      hotkeys = {
        "file-explorer:new-file-in-new-pane" = [
          {
            modifiers = [
              "Mod"
              "Shift"
            ];
            key = "N";
          }
        ];
        "workspace:close" = [
          {
            modifiers = [
              "Mod"
            ];
            key = "W";
          }
        ];
        "workspace:close-window" = [
          {
            modifiers = [
              "Mod"
              "Shift"
            ];
            key = "W";
          }
        ];
        "command-palette:open" = [
          {
            modifiers = [
              "Mod"
              "Shift"
            ];
            key = "P";
          }
        ];
        "editor:delete-paragraph" = [
          {
            modifiers = [
              "Mod"
            ];
            key = "D";
          }
        ];
        "app:reload" = [
          {
            modifiers = [
              "Mod"
            ];
            key = "R";
          }
        ];
        "editor:toggle-source" = [
          {
            modifiers = [
              "Mod"
            ];
            key = "Enter";
          }
        ];
        "editor:open-link-in-new-leaf" = [
          {
            modifiers = [
              "Mod"
              "Shift"
            ];
            key = "Enter";
          }
        ];
      };

      # Additional files to include in the vault.
      extraFiles = {};
    };
  };
}
