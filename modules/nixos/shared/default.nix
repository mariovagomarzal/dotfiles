####################################
# NixOS and Darwin shared modules. #
####################################
{...}: {
  imports = [
    ./nix-core.nix
    ./packages.nix
  ];
}
