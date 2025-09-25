#################
# Core library. #
#################
{...}: {
  importBuilder = pkgs: file: overrides: pkgs.callPackage file overrides;
}
