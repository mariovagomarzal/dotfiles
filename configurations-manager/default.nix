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

  Usage
  -----
  This function receives an attribute set. The main attribute is the `hosts`
  attribute, which is an attribute set where each key is a hostname and the
  value is another attribute set that specifies the options for building the
  NixOS configuration of the host.

  Any attribute that can be used to define a host can also be used in the
  top-level input attribute set. Then, the top-level attributes are recursively
  merged with the host-specific ones. If some attribute is not defined at any
  level, the default value will be used.

  The possible attributes are the following:
    - `debug`: A boolean that enables or disables the debug mode. When enabled,
      the function will not generate the configurations, but it will return the
      resulting attribute set that would be used to generate them. By default,
      it is set to `false`.
    - `nixpkgs`: The 'nixpkgs' instance to use for generating the NixOS
      configurations. By default, it is set to the `nixpkgs` used to import this
      library.
    - `system`: The system architecture to generate the configuration. By
      default, it is set to an empty string.
    - `specialArgs`: Extra arguments to pass to each module. In addition to the
      ones defined by this attribute, the hostname and the `users` atrribute set
      is also passed as an argument. By default, it is set to an empty attribute
      set.
    - `nixosConfigurationsDir`: The directory where the NixOS configurations are
      stored. It should be a string with the directory name. Then, it is assumed
      to be relative to the `rootDir` attribute used to import the library. By
      default, it is set to the `nixosConfigurationsDir` used to import this
      library.
    - `sharedModulesDir`: The directory name (as a string) relative to the
      `nixosConfigurationsDir` where the shared modules are stored. By default,
      it is set to `"."`, i.e., at the top-level of the configurations
      directory.
    - `excludedSharedModules`: A list of file or directory names (as strings)
      that should be excluded from the shared modules. By default, it is set to
      an empty list.
    - `extraSharedModules`: A list of modules that should be included in the
      shared modules. By default, it is set to an empty list.
    - `hostModulesDir`: The directory name (as a string) relative to the
      `nixosConfigurationsDir` where the host modules are stored. If not
      specified, it will be assumed to be the hostname.
    - `excludedHostModules`: A list of file or directory names (as strings) that
      should be excluded from the host modules. By default, it is set to an
      empty list.
    - `extraHostModules`: A list of modules that should be included in the host
      modules. By default, it is set to an empty list.
    - `extraNixosArgs`: Extra arguments to pass to the NixOS configuration
      generator. By default, it is set to an empty attribute set.
    - `home-manager`: The 'home-manager' instance to use for generating the
      Home-Manager configurations. By default, it is set to the `home-manager`
      used to import this library.
    - `homeConfigurationsDir`: The directory where the Home-Manager
      configurations are stored. It should be a string with the directory name.
      Then, it is assumed to be relative to the `rootDir` attribute used to
      import the library. By default, it is set to the `homeConfigurationsDir`
      used to import this library.
    - `homeSpecialArgs`: Extra arguments to pass to each Home-Manager module. In
      addition to the ones defined by this attribute, a `usersInfo` function is
      also passed as an argument. This function receives the `config` attribute
      set and returns the `userInfo` attribute set of the specific user. By
      default, it is set to an empty attribute set.
    - `users`: An attribute set, similar to `hosts`, but for defining the users
      configurations for each host. Each user attribute set can have the
      following attributes, which are also recursively merged with the ones
      defined in the top-level input attribute set:
        - `sharedModulesDir`: The directory name (as a string) relative to the
          `homeConfigurationsDir` where the shared modules are stored. By
          default, it is set to `"."`, i.e., at the top-level of the
          configurations directory.
        - `excludedHomeSharedModules`: A list of file or directory names (as
          strings) that should be excluded from the shared modules. By default,
          it is set to an empty list.
        - `extraHomeSharedModules`: A list of modules that should be included in
          the shared modules. By default, it is set to an empty list.
        - `userModulesDir`: The directory name (as a string) relative to the
          `homeConfigurationsDir` where the user modules are stored. If not
          specified, it will be assumed to be the username.
        - `excludedUserModules`: A list of file or directory names (as strings)
          that should be excluded from the user modules. By default, it is set
          to an empty list.
        - `extraUserModules`: A list of modules that should be included in the
          user modules. By default, it is set to an empty list.
        - `userInfo`: An attribute set with user-specific information. The
          attributes can be anything that is useful for generating the user
          configuration. By default, it is set to an empty attribute set.
        - `extraUserArgs`: Extra arguments to pass to the user configuration
          generator. By default, it is set to an empty attribute set.
    - `extraHomeManagerArgs`: Extra arguments to pass to the Home-Manager
      configuration generator. By default, it is set to an empty attribute set.
  */
  mkNixosConfigurations = system-makers.mkSystemMaker "nixos";

  /*
  Returns an attribute set where each attribute key is a hostname and the value
  is a Darwin configuration.

  Usage
  -----
  Works the same way as the `mkNixosConfigurations` function, but for Darwin
  configurations. Only the following attributes are different:
    - `nix-darwin` (instead of `nixpkgs`): The 'nix-darwin' instance to use for
      generating the Darwin configurations. By default, it is set to the
      `nix-darwin` used to import this library.
    - `darwinConfigurationsDir` (instead of `nixosConfigurationsDir`): The
      directory where the Darwin configurations are stored. By default, it is
      set to the `darwinConfigurationsDir` used to import this library.
    - `extraDarwinArgs` (instead of `extraNixosArgs`): Extra arguments to pass
      to the Darwin configuration generator. By default, it is set to an empty
      attribute set.
  */
  mkDarwinConfigurations = system-makers.mkSystemMaker "darwin";

  /*
  Returns an attribute set where each attribute key is a username and the value
  is a Home-Manager configuration.

  Usage
  -----
  Works similarly to the `mkNixosConfigurations` and `mkDarwinConfigurations`
  functions, but for Home-Manager configurations. In this function, the main
  attribute is the `users` attribute (instead of `hosts`, which is not an
  expected value). Top-level input attributes are recursively merged with the
  user-specific ones as well.

  The possible attributes are the following:
  - `debug`: A boolean that enables or disables the debug mode. When enabled,
    the function will not generate the configurations, but it will return the
    resulting attribute set that would be used to generate them. By default, it
    is set to `false`.
  - `home-manager`: The 'home-manager' instance to use for generating the
    Home-Manager configurations. By default, it is set to the `home-manager`
    used to import this library.
  - `nixpkgs`: The 'nixpkgs' instance to use for generating the `pkgs`
    attribute. By default, it is set to the `nixpkgs` used to import this
    library.
  - `system`: The system architecture to generate the configuration. By default,
    it is set to an empty string.
  - `specialArgs`: Extra arguments to pass to each module. In addition to the
    ones defined by this attribute, the `usersInfo` function is also passed as
    an argument. By default, it is set to an empty attribute set.
  - `homeConfigurationsDir`: The directory where the Home-Manager configurations
    are stored. It should be a string with the directory name. Then, it is
    assumed to be relative to the `rootDir` attribute used to import the
    library. By default, it is set to the `homeConfigurationsDir` used to import
    this library.
  - `sharedModulesDir`: The directory name (as a string) relative to the
    `homeConfigurationsDir` where the shared modules are stored. By default, it
    is set to `"."`, i.e., at the top-level of the configurations directory.
  - `excludedSharedModules`: A list of file or directory names (as strings) that
    should be excluded from the shared modules. By default, it is set to an
    empty list.
  - `extraSharedModules`: A list of modules that should be included in the shared
    modules. By default, it is set to an empty list.
  - `userModulesDir`: The directory name (as a string) relative to the
    `homeConfigurationsDir` where the user modules are stored. If not specified,
    it will be assumed to be the username.
  - `excludedUserModules`: A list of file or directory names (as strings) that
    should be excluded from the user modules. By default, it is set to an empty
    list.
  - `extraUserModules`: A list of modules that should be included in the user
    modules. By default, it is set to an empty list.
  - `userInfo`: An attribute set with user-specific information. The attributes
    can be anything that is useful for generating the user configuration. By
    default, it is set to an empty attribute set.
  - `extraHomeManagerArgs`: Extra arguments to pass to the Home Manager
    configuration generator. By default, it is set to an empty attribute set.
  */
  inherit (home-makers) mkHomeConfigurations;
}
