#######################
# Core Darwin module. #
#######################
{inputs, ...}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];
}
