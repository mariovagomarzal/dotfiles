/**
Podman on NixOS, with DNS on its default network and separate Docker commands and sockets.
*/
_: {
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
