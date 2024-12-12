############################
# SSH agent configuration. #
############################
{...}: {
  programs.ssh = {
    enable = true;

    # Configuration for all hosts.
    addKeysToAgent = "yes";
    extraConfig = ''
      AddKeysToAgent yes
    '';

    matchBlocks = {
      # GitHub host.
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
