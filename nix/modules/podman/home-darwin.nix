/**
Podman's default virtual machine with `/Users` shared at the same path with write access.

Home Manager only sets mounts when creating a machine; changing them does not update an existing machine.
*/
_: {
  services.podman = {
    useDefaultMachine = false;
    machines.podman-machine-default.volumes = [
      "/Users:/Users:rw"
      "/private:/private"
      "/var/folders:/var/folders"
    ];
  };
}
