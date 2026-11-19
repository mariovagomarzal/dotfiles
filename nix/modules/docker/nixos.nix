/**
Rootless Docker on NixOS, with the client pointed at the user's socket.

The daemon runs as a user service, without membership in the privileged `docker` group, and uses its own socket
alongside Podman.
*/
_: {
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
