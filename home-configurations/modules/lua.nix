#######################################
# Custom Home-Manager module for Lua. #
#######################################
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

      extraLuaPackages = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
          Additional Lua packages to install.

          The resulting list should be the names (as strings) you would normally
          use in a `withPackages` call, i.e.:
          ```
          lua.withPackages (ps: with ps; [
            # Your packages here.
          ])
          ```
        '';
        example = ''
          ["luarocks"]
        '';
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = ''
          Additional Lua packages to install.

          The resulting list should be the packages not available in the
          `luaPackages` package set used in the `lua.withPackages` call.
        '';
        example = ''
          [customLuaPackage]
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
  config = let
    # Returns a list of packages within the given `ps` package set.
    withLuaPackages = ps: packageNames:
      lib.forEach packageNames (
        name:
          ps."${name}"
      );
  in
    mkIf cfg.enable (mkMerge [
      {
        # Wrap the Lua package with the extra packages.
        programs.lua.finalPackage = cfg.package.withPackages (
          ps:
            (withLuaPackages ps cfg.extraLuaPackages) ++ cfg.extraPackages
        );

        # Add the final package to the list of packages to install.
        home.packages = [cfg.finalPackage];
      }
    ]);
}
