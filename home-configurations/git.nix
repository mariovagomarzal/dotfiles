######################
# Git configuration. #
######################
{
  config,
  usersInfo,
  ...
}: let
  userInfo = usersInfo config;
in {
  programs.git = {
    enable = true;

    # User name and email.
    userName = config.home.username;
    userEmail = userInfo.email;

    # Extra configuration.
    extraConfig = {
      # GitHub related configuration.
      github.user = userInfo.githubUser;

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

      # Signing configuration.
      tag.gpgsign = true;
    };

    # Delta pager.
    delta.enable = true;

    # Git aliases.
    aliases = {
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
      "r" = "rebase";
      "s" = "status";
      "t" = "tag";
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
