inputs: let
  importLib = file: import file inputs;
in {
  modules = importLib ./modules.nix;
}
