/**
Uses IINA as the mpv front end on macOS, pointed at the mpv configuration that
home-manager writes, instead of installing mpv itself.
*/
{config, ...}: {
  programs.mpv.package = null;

  targets.darwin.defaults."com.colliderli.iina" = {
    enableAdvancedSettings = true;
    useUserDefinedConfDir = true;
    userDefinedConfDir = "${config.xdg.configHome}/mpv/";
  };
}
