##################################
# SSH configuration home module. #
##################################
{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      # Configuration for all hosts.
      "*" = {
        addKeysToAgent = "yes";
      };

      # GitHub host.
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
