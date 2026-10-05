{
  inputs,
  flake,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (flake) modules;

  coreModules = [
    "core"
    "options"
  ];

  flattenModulesToList = modules:
    lib.concatMap
    lib.attrValues
    (lib.attrValues modules);

  modulesOfType = type: modules.${type} or {};

  modulesOfTypeWithout = type: exclude: let
    allModules = modulesOfType type;
  in
    lib.removeAttrs allModules exclude;

  modulesOfTypeWith = type: include: let
    allModules = modulesOfType type;
  in
    lib.getAttrs include allModules;

  modulesAttrWithout = excludeByType:
    lib.mapAttrs
    (type: exclude: modulesOfTypeWithout type exclude)
    excludeByType;

  modulesAttrWithBase = baseModules: includeByType:
    lib.mapAttrs
    (type: include: modulesOfTypeWith type (baseModules ++ include))
    includeByType;

  modulesAttrWith = modulesAttrWithBase [];

  coreModulesAttrWith = modulesAttrWithBase coreModules;

  modulesFromAttr = attrFn: namesByType:
    flattenModulesToList (attrFn namesByType);
in {
  modulesWithout = modulesFromAttr modulesAttrWithout;

  modulesWith = modulesFromAttr modulesAttrWith;

  coreModulesWith = modulesFromAttr coreModulesAttrWith;
}
