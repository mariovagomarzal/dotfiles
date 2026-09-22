####################
# Modules library. #
####################
{
  inputs,
  flake,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (flake) modules;

  # Core modules that are always included in base configurations.
  coreModules = [
    "core"
    "options"
  ];

  # Convert nested module attrsets to a flat list of modules.
  flattenModulesToList = modules:
    lib.concatMap
    (lib.attrValues)
    (lib.attrValues modules);

  # Get all modules of a specific type (e.g., "nixos", "darwin").
  modulesOfType = type: modules.${type} or {};

  # Get modules of a type excluding specified module names.
  modulesOfTypeWithout = type: exclude: let
    allModules = modulesOfType type;
  in
    lib.removeAttrs allModules exclude;

  # Get only specified modules of a type by name.
  modulesOfTypeWith = type: include: let
    allModules = modulesOfType type;
  in
    lib.getAttrs include allModules;

  # Apply exclusion filtering across multiple module types.
  # Takes an attrset mapping type to list of module names to exclude.
  modulesAttrWithout = excludeByType:
    lib.mapAttrs
    (type: exclude: modulesOfTypeWithout type exclude)
    excludeByType;

  # Apply inclusion filtering with base modules across multiple types.
  # Base modules are always included in addition to specified ones.
  modulesAttrWithBase = baseModules: includeByType:
    lib.mapAttrs
    (type: include: modulesOfTypeWith type (baseModules ++ include))
    includeByType;

  # Apply inclusion filtering without any base modules.
  modulesAttrWith = modulesAttrWithBase [];

  # Apply inclusion filtering with core modules as base.
  coreModulesAttrWith = modulesAttrWithBase coreModules;

  # Convert filtered module attributes to a flat list using the given function.
  modulesFromAttr = attrFn: namesByType:
    flattenModulesToList (attrFn namesByType);
in {
  modulesWithout = modulesFromAttr modulesAttrWithout;

  modulesWith = modulesFromAttr modulesAttrWith;

  coreModulesWith = modulesFromAttr coreModulesAttrWith;
}
