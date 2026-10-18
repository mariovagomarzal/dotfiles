/**
Podman with its Compose provider and a virtual machine created on activation and started at login on macOS.

Home Manager manages the default Podman machine on macOS and removes machines outside its configuration.
The Nix package includes the virtualisation and networking helpers. Docker keeps its own commands and socket.
On Linux, the host must provide rootless container support; NixOS uses this feature's system module.
*/
{
  lib,
  pkgs,
  ...
}: {
  services.podman = {
    enable = true;
    settings.containers.engine.compose_providers = [(lib.getExe pkgs.podman-compose)];
  };

  home.packages = [pkgs.podman-compose];
}
