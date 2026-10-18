/**
Docker's command-line client, including the Compose and Buildx plugins.

The engine is provided by the platform module: Colima on macOS or rootless Docker on NixOS. On other Linux
distributions, the host must provide an engine. Docker's client configuration stays writable for logins and contexts.
*/
{pkgs, ...}: {
  home.packages = [pkgs.docker];
}
