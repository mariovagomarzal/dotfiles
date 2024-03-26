############################
# SSH agent configuration. #
############################
{...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      AddKeysToAgent yes
    '';

    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
