##########################################################
# Custom nix-darwin module for Yabai scripting addition. #
##########################################################
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

  # Yabai scripting addition configuration object.
  cfg = config.yabaiScriptingAddition;
in {
  # Options for the Yabai scripting addition module.
  options = {
    yabaiScriptingAddition = {
      enable = mkEnableOption "yabaiScriptingAddition";

      package = mkPackageOption pkgs "yabai" {};
    };
  };

  # Yabai scripting addition configuration.
  config = mkIf cfg.enable (mkMerge [
    {
      # Allow admin users to run `yabai --load-sa` without password.
      environment.etc."sudoers.d/yabai".source = pkgs.runCommand "sudoers-yabai" {} ''
        YABAI_BIN="${cfg.package}/bin/yabai"
        SHASUM=$(sha256sum "$YABAI_BIN" | cut -d' ' -f1)
        cat <<EOF >"$out"
        %admin ALL=(root) NOPASSWD: sha256:$SHASUM $YABAI_BIN --load-sa
        EOF
      '';
    }
  ]);
}
