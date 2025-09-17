##################################
# Custom Yabai-SA Darwin module. #
##################################
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
  cfg = config.yabai-sa;
in {
  # Options for the Yabai scripting addition module.
  options = {
    yabai-sa = {
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
