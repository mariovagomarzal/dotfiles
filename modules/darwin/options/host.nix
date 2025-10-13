######################################
# Custom host Darwin options module. #
######################################
{
  config,
  lib,
  ...
}: let
  # Options related functions.
  inherit
    (lib)
    mkOption
    types
    mkIf
    mkMerge
    ;

  # Host configuration object.
  cfg = config.host;
in {
  # Options for the host module.
  options.host = {
    hostname = mkOption {
      type = types.str;
      default = "";
      description = "The hostname of the machine.";
    };
    computername = mkOption {
      type = types.str;
      default = "";
      description = "The computer name of the machine.";
    };
  };

  # Host configuration.
  config = mkMerge [
    (
      mkIf (cfg.hostname != "") {
        networking.hostName = cfg.hostname;
        system.defaults.smb = {
          NetBIOSName = cfg.hostname;
          ServerDescription = cfg.hostname;
        };
      }
    )
    (
      mkIf (cfg.computername != "") {
        networking.computerName = cfg.computername;
      }
    )
  ];
}
