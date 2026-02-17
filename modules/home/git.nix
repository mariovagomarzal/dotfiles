####################
# Git home module. #
####################
{...}: {
  programs.git = {
    enable = true;

    # Extra configuration.
    settings = {
      # User information.
      user = {
        name = "mariovagomarzal";
        email = "mariovagomarzal@gmail.com";
      };

      # GitHub related configuration.
      github.user = "mariovagomarzal";

      # Key related configuration.
      gpg.format = "ssh";
      credential.helper = "osxkeychain";
      user.signingkey = "~/.ssh/id_ed25519";

      # Core configuration.
      core = {
        editor = "nvim";
      };

      # Init configuration.
      init = {
        defaultBranch = "main";
      };

      # Color configuration.
      color = {
        ui = "auto";
        branch = {
          current = "yellow bold";
          local = "yellow";
          remote = "cyan";
        };
        status = {
          added = "green bold";
          changed = "cyan bold";
          untracked = "red bold";
        };
      };

      # Diff configuration.
      diff = {
        tool = "nvimdiff";
      };

      # Merge configuration.
      merge = {
        tool = "nvimdiff";
        log = true;
        conflictstyle = "diff3";
      };

      # Signing configuration.
      tag.gpgsign = true;

      # Aliases.
      alias = {
        "a" = "add";
        "b" = "branch";
        "c" = "commit";
        "cm" = "commit -m";
        "co" = "checkout";
        "d" = "diff";
        "f" = "fetch";
        "g" = "log --graph";
        "l" = "log";
        "m" = "merge";
        "p" = "push";
        "pl" = "pull";
        "r" = "restore";
        "rs" = "restore --staged";
        "rb" = "rebase";
        "s" = "status";
        "t" = "tag";
      };
    };

    # Global git ignores.
    ignores = [
      # macOS related files.
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"

      # Icon must end with two \r
      "Icon"

      # Thumbnails
      "._*"

      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # iCloud generated files
      "*.icloud"
    ];
  };
}
