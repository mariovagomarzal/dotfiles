#######################################################
# Entry point for the configurations manager library. #
#######################################################
args: let
  # The 'nixpkgs' library.
  lib = args.nixpkgs-lib;

  # A set of utility functions for the library.
  utils = import ./utils.nix (args // {inherit lib;});

  # Import a module with the given arguments, the 'nixpkgs' library and the
  # 'utils' functions.
  importWithArgs = module: let
    args' = args // {inherit lib utils;};
  in
    import module args';

  # Defines the `mkSystemMaker` function, which when given a system type,
  # returns the final function that will generate the NixOS or Darwin
  # configurations.
  system-makers = importWithArgs ./system-makers.nix;

  # Defines the `mkHomeConfigurations` function, which generates standalone
  # Home-Manager configurations.
  home-makers = importWithArgs ./home-makers.nix;
in {
  /*
  Returns an attribute set where each attribute key is a hostname and the value
  is a NixOS configuration.

  # Usage
  TODO: Add usage.
  */
  mkNixosConfigurations = system-makers.mkSystemMaker "nixos";

  /*
  Returns an attribute set where each attribute key is a hostname and the value
  is a Darwin configuration.

  # Usage
  TODO: Add usage.
  */
  mkDarwinConfigurations = system-makers.mkSystemMaker "darwin";

  /*
  Returns an attribute set where each attribute key is a username and the value
  is a Home-Manager configuration.

  # Usage
  TODO: Add usage.
  */
  inherit (home-makers) mkHomeConfigurations;
}
