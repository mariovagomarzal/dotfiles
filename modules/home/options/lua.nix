###########################
# Custom Lua home module. #
###########################
{
  config,
  lib,
  pkgs,
  ...
}: let
  # Options related functions.
  inherit
    (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    types
    mkIf
    mkMerge
    ;

  # Lua program configuration object.
  cfg = config.programs.lua;
in {
  # Options for the Lua program module.
  options = {
    programs.lua = {
      enable = mkEnableOption "lua";

      package = mkPackageOption pkgs "lua" {};

      extraPackages = mkOption {
        type = types.listOf (types.functionTo (types.listOf types.package));
        default = [];
        description = ''
          Additional Lua packages/modules to install.

          This option consist in a list of functions that will receive the
          Lua package set as argument and return a list of packages/modules to
          extend the Lua package with. The resulting lists of calling every
          function will be concatenated and added to the Lua package.
        '';
        example = ''
          [(ps: with ps; [luarocks])]
        '';
      };

      finalPackage = mkOption {
        type = types.nullOr types.package;
        readOnly = true;
        description = ''
          The final package to install, including all the extra packages.
        '';
      };
    };
  };

  # Lua program configuration.
  config = mkIf cfg.enable (mkMerge [
    {
      # Wrap the Lua package with the extra packages.
      programs.lua.finalPackage = cfg.package.withPackages (
        ps:
          lib.concatLists (map (f: f ps) cfg.extraPackages)
      );

      # Add the final package to the list of packages to install.
      home.packages = [cfg.finalPackage];
    }
  ]);
}
