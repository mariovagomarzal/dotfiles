/**
Git with SSH-signed tags, nvimdiff as diff and merge tool, short aliases and
global ignores for macOS and iCloud files.

Signing uses the public key from the `ssh` module, with the private key
served by KeePassXC's agent, and my own GitHub repositories are reached over SSH
rather than HTTPS.
*/
{config, ...}: let
  publicKey = config.home.file.".ssh/mariovagomarzal.pub".text;
in {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "mariovagomarzal";
        email = "mariovagomarzal@gmail.com";
      };

      github.user = "mariovagomarzal";

      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
      credential.helper = "osxkeychain";
      user.signingkey = "~/.ssh/mariovagomarzal.pub";

      # Only my own repositories: cloning anyone else's stays anonymous over HTTPS and needs no unlocked agent.
      url."git@github.com:mariovagomarzal/".insteadOf = "https://github.com/mariovagomarzal/";

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
      "Icon\r\r"

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

  # Lets `git verify-tag` and `git log --show-signature` check signatures locally.
  xdg.configFile."git/allowed_signers".text = "mariovagomarzal@gmail.com namespaces=\"git\" ${publicKey}";
}
