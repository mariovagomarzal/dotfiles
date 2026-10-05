_: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "mariovagomarzal";
        email = "mariovagomarzal@gmail.com";
      };

      github.user = "mariovagomarzal";

      gpg.format = "ssh";
      credential.helper = "osxkeychain";
      user.signingkey = "~/.ssh/id_ed25519";

      core = {
        editor = "nvim";
      };

      init = {
        defaultBranch = "main";
      };

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

      diff = {
        tool = "nvimdiff";
      };

      merge = {
        tool = "nvimdiff";
        log = true;
        conflictstyle = "diff3";
      };

      tag.gpgsign = true;

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

    ignores = [
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"

      # Icon must end with two \r
      "Icon"

      "._*"

      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      "*.icloud"
    ];
  };
}
