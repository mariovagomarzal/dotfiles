###################################
# Library for the dotfiles flake. #
###################################
inputs: let
  # Auxiliary function to import libraries.
  importLib = file: import file inputs;
in {
  modules = importLib ./modules.nix;
}
