/**
The eduVPN client on Linux, from nixpkgs. It sets up connections through NetworkManager.
*/
{pkgs, ...}: {
  home.packages = [pkgs.eduvpn-client];
}
