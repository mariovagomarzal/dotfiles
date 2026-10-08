/**
SSH client configuration, with the private key served by KeePassXC's agent.

Only the public key is kept here, in `~/.ssh/mariovagomarzal.pub`: pointing
`IdentityFile` at it makes SSH pick the matching key from the agent. Other
modules, such as `git`, read the key from this file too.
*/
_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."github.com" = {
      identityFile = "~/.ssh/mariovagomarzal.pub";
      identitiesOnly = true;
    };
  };

  home.file.".ssh/mariovagomarzal.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO/707M6eyzrXPQjJTSYzKksHy35vGXsmO5FtPamb4aG mariovagomarzal@gmail.com\n";
}
