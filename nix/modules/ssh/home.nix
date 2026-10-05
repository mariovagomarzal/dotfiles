/**
SSH client configuration: keys are added to the agent, and GitHub uses the
ed25519 key.
*/
_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        addKeysToAgent = "yes";
      };

      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
