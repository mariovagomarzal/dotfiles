/**
Tailscale on NixOS, through its system module, which runs the daemon for every user of the machine.
*/
_: {
  services.tailscale.enable = true;
}
