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
