####################
# Modules library. #
####################
{flake, ...}: let
  # Get modules of a specific type from the flake, defaulting to empty set if
  # not found.
  typeModules = type: flake.modules.${type} or {};

  # Core module names that should be included by default when available.
  coreModulesNames = [
    "core"
    "options"
  ];

  # Extract core modules from a module attribute se.t
  # Only includes core modules that actually exist in the attribute set.
  coreModules = typeModulesAttr:
    builtins.concatMap
    (name:
      if builtins.hasAttr name typeModulesAttr
      then [typeModulesAttr.${name}]
      else [])
    coreModulesNames;

  # Module type names for consistent reference.
  nixosModulesName = "nixos";
  darwinModulesName = "darwin";
  homeModulesName = "home";
in rec {
  # Get all modules of a type except the specified ones.
  # Returns a list of modules.
  typeModulesWithout = type: modules: let
    typeModulesAttr = typeModules type;
    withoutModulesAttr = builtins.removeAttrs typeModulesAttr modules;
  in
    builtins.attrValues withoutModulesAttr;

  # Get core modules plus specified additional modules for a given type. Core
  # modules are included only if they exist. Additional modules must exist.
  # Returns a list of modules.
  typeCoreModulesWith = type: modules: let
    typeModulesAttr = typeModules type;
    coreModulesList = coreModules typeModulesAttr;
    modulesList = builtins.concatMap (name: [typeModulesAttr.${name}]) modules;
  in
    coreModulesList ++ modulesList;

  # NixOS-specific module functions
  nixosModulesWithout = typeModulesWithout nixosModulesName;
  nixosCoreModulesWith = typeCoreModulesWith nixosModulesName;

  # Darwin-specific module functions
  darwinModulesWithout = typeModulesWithout darwinModulesName;
  darwinCoreModulesWith = typeCoreModulesWith darwinModulesName;

  # Home Manager-specific module functions
  homeModulesWithout = typeModulesWithout homeModulesName;
  homeCoreModulesWith = typeCoreModulesWith homeModulesName;
}
