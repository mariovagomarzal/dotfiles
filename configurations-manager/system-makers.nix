##############################################
# Functions to create system configurations. #
##############################################
{
  lib,
  utils,
  nixpkgs,
  nix-darwin,
  home-manager,
  nixosConfigurationsDir ? "nixos-configurations",
  darwinConfigurationsDir ? "darwin-configurations",
  homeConfigurationsDir ? "home-configurations",
  ...
}: let
  /*
  Receives a system configuration type and a key and returns the corresponding
  key for that type in the `defaultArgs` attribute set.
  */
  perTypeInfo = type: key: let
    perTypeKeys = {
      "nixos" = {
        "configurationMaker" = "nixpkgs";
        "makerFunction" = "nixosSystem";
        "configurationsDir" = "nixosConfigurationsDir";
        "extraArgs" = "extraNixosArgs";
        "homeManagerModule" = "nixosModules";
      };
      "darwin" = {
        "configurationMaker" = "nix-darwin";
        "makerFunction" = "darwinSystem";
        "configurationsDir" = "darwinConfigurationsDir";
        "extraArgs" = "extraDarwinArgs";
        "homeManagerModule" = "darwinModules";
      };
    };
  in
    perTypeKeys.${type}.${key};

  /*
  Returns the configuration maker function for the given type.
  */
  getConfigurationMaker = type: args: let
    configurationMaker = perTypeInfo type "configurationMaker";
    makerFunction = perTypeInfo type "makerFunction";
  in
    args.${configurationMaker}.lib.${makerFunction};

  /*
  Returns the modules for a system configuration.
  */
  getSystemModules = type: args: let
    configurationsDirKey = perTypeInfo type "configurationsDir";
    configurationsDir = args.${configurationsDirKey};
    sharedModulesDir = configurationsDir + "/" + args.sharedModulesDir;
    hostModulesDir = configurationsDir + "/" + args.hostModulesDir;
  in
    (utils.getModules
      sharedModulesDir
      args.excludedSharedModules
      args.extraSharedModules)
    ++ (utils.getModules
      hostModulesDir
      args.excludedHostModules
      args.extraHostModules);

  /*
  Returns the Home-Manager module for the given type.
  */
  getHomeManagerModule = type: args: let
    homeManagerModule = perTypeInfo type "homeManagerModule";
  in
    args.home-manager.${homeManagerModule}.home-manager;

  /*
  Returns the modules for a user configuration.
  */
  getUserModules = args: let
    configurationsDir = args.homeConfigurationsDir;
    sharedModulesDir = configurationsDir + "/" + args.sharedModulesDir;
    userModulesDir = configurationsDir + "/" + args.userModulesDir;
  in
    (utils.getModules
      sharedModulesDir
      args.excludedHomeSharedModules
      args.extraHomeSharedModules)
    ++ (utils.getModules
      userModulesDir
      args.excludedUserModules
      args.extraUserModules);

  /*
  Prepares the context for the user configuration, that is, the necessary
  components to generate the configuration attribute set.
  */
  mkUserContext = username: userArgs: args: let
    args' = {userModulesDir = username;} // args;
    mergedArgs = lib.recursiveUpdate args' userArgs;
  in {
    imports = getUserModules mergedArgs;
    extraUserArgs = mergedArgs.extraUserArgs;
  };

  /*
  Given a username, its arguments, and the global arguments, returns the user
  configuration attribute set.
  */
  mkUserConfiguration = username: userArgs: args: let
    context = mkUserContext username userArgs args;
  in
    lib.recursiveUpdate {
      inherit (context) imports;
    }
    context.extraUserArgs;

  /*
  Returns an attribute set where each key is a username and the value is the
  user configuration attribute set.
  */
  mkUsersConfigurations = args @ {users, ...}:
    lib.mapAttrs (
      username: userArgs:
        mkUserConfiguration username userArgs args
    )
    users;

  /*
  Prepares the context for the Home-Manager module, that is, the necessary
  components to generate the module, its global options and the users options.
  */
  mkHomeModuleContext = type: args: let
    usersInfo = config: args.users.${config.home.username}.userInfo;
  in {
    homeManagerModule = getHomeManagerModule type args;
    extraSpecialArgs = {inherit usersInfo;} // args.homeSpecialArgs;
    extraHomeManagerArgs = args.extraHomeManagerArgs;
    users = mkUsersConfigurations args;
  };

  /*
  Returns the Home-Manager module for the given type. This includes the global
  options and the users options as an attribute set.
  */
  mkHomeModule = type: args: let
    context = mkHomeModuleContext type args;
  in [
    context.homeManagerModule
    {
      home-manager =
        lib.recursiveUpdate {
          inherit
            (context)
            extraSpecialArgs
            users
            ;
        }
        context.extraHomeManagerArgs;
    }
  ];

  /*
  Prepares the context for the host configuration, that is, the necessary
  components to generate the configuration.
  */
  mkHostContext = type: hostname: hostArgs: args: let
    args' = {hostModulesDir = hostname;} // args;
    mergedArgs = lib.recursiveUpdate args' hostArgs;
  in {
    configurationMaker =
      if mergedArgs.debug
      then (x: x)
      else getConfigurationMaker type mergedArgs;
    system = mergedArgs.system;
    specialArgs =
      {
        inherit hostname;
        inherit (mergedArgs) users;
      }
      // mergedArgs.specialArgs;
    modules =
      (getSystemModules type mergedArgs)
      ++ (mkHomeModule type mergedArgs);
    extraArgs = mergedArgs.${perTypeInfo type "extraArgs"};
  };

  /*
  Given a hostname, its arguments, and the global arguments, returns the host
  configuration based on the given type.
  */
  mkHostConfiguration = type: hostname: hostArgs: args: let
    context = mkHostContext type hostname hostArgs args;
  in
    context.configurationMaker (lib.recursiveUpdate {
        inherit
          (context)
          system
          specialArgs
          modules
          ;
      }
      context.extraArgs);

  /*
  An attribute set with the default arguments for the resulting functions of the
  `mkSystemMaker` function.

  Some attributes are commented out to indicate that they are possible input
  arguments. However, their default values ​​are defined elsewhere in the code
  so that those values ​​can be set based on the hostname or username.
  */
  defaultArgs = {
    debug = false;
    nixpkgs = nixpkgs;
    nix-darwin = nix-darwin;
    system = "";
    specialArgs = {};
    nixosConfigurationsDir = nixosConfigurationsDir;
    darwinConfigurationsDir = darwinConfigurationsDir;
    sharedModulesDir = ".";
    excludedSharedModules = [];
    extraSharedModules = [];
    # hostModulesDir = hostname;
    excludedHostModules = [];
    extraHostModules = [];
    extraNixosArgs = {};
    extraDarwinArgs = {};
    home-manager = home-manager;
    homeConfigurationsDir = homeConfigurationsDir;
    homeSpecialArgs = {};
    users = {};
    # sharedModulesDir = ".";
    excludedHomeSharedModules = [];
    extraHomeSharedModules = [];
    # userModulesDir = username;
    excludedUserModules = [];
    extraUserModules = [];
    userInfo = {};
    extraUserArgs = {};
    extraHomeManagerArgs = {};
  };
in {
  /*
  Receives a system type (either "nixos" or "darwin") and returns a function
  that will generate the configurations for the given type. The resulting
  functions are documented in the './default.nix' file.
  */
  mkSystemMaker = type: args @ {hosts ? {}, ...}:
    lib.mapAttrs (
      hostname: hostArgs:
        mkHostConfiguration type hostname hostArgs (defaultArgs // args)
    )
    hosts;
}
