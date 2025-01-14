#########################################################
# Functions to create (standalone) home configurations. #
#########################################################
{
  lib,
  utils,
  home-manager,
  nixpkgs,
  homeConfigurationsDir ? "home-configurations",
  ...
}: let
  /*
  Returns the modules for a user configuration.
  */
  getHomeModules = username: args: let
    usernameModule = {...}: {home.username = username;};
    configurationsDir = args.homeConfigurationsDir;
    sharedModulesDir = configurationsDir + "/" + args.sharedModulesDir;
    userModulesDir = configurationsDir + "/" + args.userModulesDir;
  in
    (lib.singleton usernameModule)
    ++ (utils.getModules
      sharedModulesDir
      args.excludedSharedModules
      args.extraSharedModules)
    ++ (utils.getModules
      userModulesDir
      args.excludedUserModules
      args.extraUserModules);

  /*
  Prepares the context for a user configuration, that is, the necessary
  components to generate the configuration.
  */
  mkUserContext = username: userArgs: args: let
    args' = {userModulesDir = username;} // args;
    mergedArgs = lib.recursiveUpdate args' userArgs;
  in {
    configurationMaker =
      if mergedArgs.debug
      then (x: x)
      else mergedArgs.home-manager.lib.homeManagerConfiguration;
    pkgs = mergedArgs.nixpkgs.legacyPackages.${mergedArgs.system};
    modules = getHomeModules username mergedArgs;
    extraSpecialArgs = {inherit usersInfo;} // mergedArgs.specialArgs;
    extraArgs = mergedArgs.extraHomeManagerArgs;
  };

  /*
  Given a username, its arguments, and the global arguments, returns the user
  configuration.
  */
  mkUserConfiguration = username: userArgs: args: let
    context = mkUserContext username userArgs args;
  in
    context.configurationMaker (lib.recursiveUpdate {
        inherit
          (context)
          pkgs
          modules
          extraSpecialArgs
          ;
      }
      context.extraArgs);

  /*
  An attribute set with the default arguments for the `mkHomeConfigurations`
  function.

  Some attributes are commented out to indicate that they are possible input
  arguments. However, their default values ​​are defined elsewhere in the code
  so that those values ​​can be set based on the username.
  */
  defaultArgs = {
    debug = false;
    home-manager = home-manager;
    nixpkgs = nixpkgs;
    system = "";
    specialArgs = {};
    homeConfigurationsDir = homeConfigurationsDir;
    sharedModulesDir = ".";
    excludedSharedModules = [];
    extraSharedModules = [];
    # userModulesDir = <username>;
    excludedUserModules = [];
    extraUserModules = [];
    userInfo = {};
    extraHomeManagerArgs = {};
  };
in {
  /*
  This function is document in the './default.nix' file.
  */
  mkHomeConfigurations = args @ {users ? {}, ...}:
    lib.mapAttrs (
      username: userArgs:
        mkUserConfiguration username userArgs (defaultArgs // args)
    )
    users;
}
