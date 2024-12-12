######################
# Git configuration. #
######################
{
  userName,
  userEmail,
  ...
}: {
  programs.git = {
    enable = true;

    # User name and email.
    inherit userName userEmail;

    # Extra configuration.
    extraConfig = {
      # Core configuration.
      core = {
        editor = "code --wait";
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
        tool = "code";
      };

      difftool."code".cmd = "code --wait --diff $LOCAL $REMOTE";

      # Merge configuration.
      merge = {
        tool = "code";
        log = true;
        conflictstyle = "diff3";
      };

      mergetool."code".cmd = "code --wait $MERGED";

      # Key related configuration.
      gpg.format = "ssh";
      credential.helper = "osxkeychain";
      tag.gpgsign = true;
      user.signingkey = "~/.ssh/id_ed25519";

      # GitHub related configuration.
      github.user = userName;
    };

    # Delta pager.
    delta = {
      enable = true;
      options = {
        features = "line-numbers side-by-side decorations";
        theme = "Dracula";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        line-numbers = {
          line-numbers-left-style = "cyan";
          line-numbers-right-style = "cyan";
          line-numbers-minus-style = "124";
          line-numbers-plus-style = "28";
        };
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
