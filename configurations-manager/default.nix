#######################################################
# Entry point for the configurations manager library. #
#######################################################
{
  nixpkgs-lib,
  nixpkgs,
  nix-darwin,
  home-manager,
  rootDir,
  darwinConfigurationsDir ? "darwin-configurations",
  nixosConfigurationsDir ? "nixos-configurations",
  homeConfigurationsDir ? "home-configurations",
  ...
}: let
  lib = nixpkgs-lib;

  perTypeInfo = type: key: let
    perTypeKeys = {
      "nixos" = {
        "configurationMaker" = "nixpkgs";
        "makerFunction" = "nixosSystem";
        "sharedModulesDir" = "nixosConfigurationsDir";
        "extraArgs" = "extraNixosArgs";
        "homeConfigurationMaker" = "home-manager";
        "homeMakerFunction" = "nixosModules";
      };
      "darwin" = {
        "configurationMaker" = "nix-darwin";
        "makerFunction" = "darwinSystem";
        "sharedModulesDir" = "darwinConfigurationsDir";
        "extraArgs" = "extraDarwinArgs";
        "homeConfigurationMaker" = "home-manager";
        "homeMakerFunction" = "darwinModules";
      };
    };
  in
    perTypeKeys.${type}.${key};

  getConfigurationMaker = type: args: let
    configurationMaker = perTypeInfo type "configurationMaker";
    makerFunction = perTypeInfo type "makerFunction";
  in
    args.${configurationMaker}.lib.${makerFunction};

  getNixFiles = dir: excludedModules: extraModules: let
    path = rootDir + ("/" + dir);
    files = builtins.readDir path;
    filteredFiles = lib.mapAttrsToList (fileName: _: fileName) (
      lib.filterAttrs (
        fileName: fileType:
          fileType
          == "regular"
          && ! (lib.elem fileName excludedModules)
          && (lib.hasSuffix ".nix" fileName)
      )
      files
    );
  in
    lib.map (fileName: path + ("/" + fileName)) filteredFiles ++ extraModules;

  getSharedModules = sharedModulesDir: args:
    getNixFiles
    sharedModulesDir
    args.excludedSharedModules
    args.extraSharedModules;

  getHostModules = hostConfigurationDir: args:
    getNixFiles
    hostConfigurationDir
    args.excludedHostModules
    args.extraHostModules;

  getModules = type: args: let
    sharedModulesDirKey = perTypeInfo type "sharedModulesDir";
    sharedModulesDir = args.${sharedModulesDirKey};
    hostConfigurationDir = sharedModulesDir + "/" + args.hostConfigurationDir;
  in
    (getSharedModules sharedModulesDir args)
    ++ (getHostModules hostConfigurationDir args);

  getHomeConfigurationMaker = type: args: let
    homeConfigurationMaker = perTypeInfo type "homeConfigurationMaker";
    homeMakerFunction = perTypeInfo type "homeMakerFunction";
  in
    args.${homeConfigurationMaker}.${homeMakerFunction}.home-manager;

  getUserSharedModules = sharedModulesDir: args:
    getNixFiles
    sharedModulesDir
    args.excludedHomeSharedModules
    args.extraHomeSharedModules;

  getUserModules = userConfigurationDir: args:
    getNixFiles
    userConfigurationDir
    args.excludedUserModules
    args.extraUserModules;

  getUserImports = args: let
    sharedModulesDir = args.homeConfigurationsDir;
    userConfigurationDir = sharedModulesDir + "/" + args.userConfigurationDir;
  in
    (getUserSharedModules sharedModulesDir args)
    ++ (getUserModules userConfigurationDir args);

  mkUserContext = userName: userArgs: args: let
    args' = args // {userConfigurationDir = userName;};
    mergedArgs = lib.recursiveUpdate args' userArgs;
  in {
    imports = getUserImports mergedArgs;
    extraUserArgs = mergedArgs.extraUserArgs;
  };

  mkUserAttrs = userName: userArgs: args: let
    context = mkUserContext userName userArgs args;
  in
    lib.recursiveUpdate {
      inherit (context) imports;
    }
    context.extraUserArgs;

  mkUsersAttrs = args @ {users, ...}:
    lib.mapAttrs (
      userName: userArgs:
        mkUserAttrs userName userArgs args
    )
    users;

  mkHomeModuleContext = type: hostName: args: {
    configurationMaker = getHomeConfigurationMaker type args;
    extraSpecialArgs =
      {
        inherit hostName;
      }
      // args.extraHomeSpecialArgs;
    users = mkUsersAttrs args;
    extraHomeManagerArgs = args.extraHomeManagerArgs;
  };

  mkHomeModule = type: hostName: args: let
    context = mkHomeModuleContext type hostName args;
  in [
    context.configurationMaker
    (
      lib.recursiveUpdate {
        home-manager = {
          inherit
            (context)
            extraSpecialArgs
            users
            ;
        };
      }
      context.extraHomeManagerArgs
    )
  ];

  mkHostContext = type: hostName: hostArgs: args: let
    args' = args // {hostConfigurationDir = hostName;};
    mergedArgs = lib.recursiveUpdate args' hostArgs;
  in {
    configurationMaker =
      if mergedArgs.debug
      then (x: x)
      else getConfigurationMaker type mergedArgs;
    system = mergedArgs.system;
    specialArgs =
      {
        inherit hostName;
        inherit (mergedArgs) users;
      }
      // mergedArgs.extraSpecialArgs;
    modules =
      (getModules type mergedArgs)
      ++ (mkHomeModule type hostName mergedArgs);
    extraArgs = mergedArgs.${perTypeInfo type "extraArgs"};
  };

  mkHostConfiguration = type: hostName: hostArgs: args: let
    context = mkHostContext type hostName hostArgs args;
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

  defaultArgs = {
    debug = false;
    nixpkgs = nixpkgs;
    nix-darwin = nix-darwin;
    system = "";
    extraSpecialArgs = {};
    nixosConfigurationsDir = nixosConfigurationsDir;
    darwinConfigurationsDir = darwinConfigurationsDir;
    excludedSharedModules = [];
    extraSharedModules = [];
    excludedHostModules = [];
    extraHostModules = [];
    extraNixosArgs = {};
    extraDarwinArgs = {};
    home-manager = home-manager;
    homeConfigurationsDir = homeConfigurationsDir;
    excludedHomeSharedModules = [];
    extraHomeSharedModules = [];
    excludedUserModules = [];
    extraUserModules = [];
    extraHomeSpecialArgs = {};
    extraUserArgs = {};
    extraHomeManagerArgs = {};
    users = {};
  };

  mkSystemMaker = type: args @ {hosts ? {}, ...}:
    lib.mapAttrs (
      hostName: hostArgs:
        mkHostConfiguration type hostName hostArgs (defaultArgs // args)
    )
    hosts;
in {
  mkNixosConfigurations = mkSystemMaker "nixos";
  mkDarwinConfigurations = mkSystemMaker "darwin";
}
