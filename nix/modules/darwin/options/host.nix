{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkOption
    types
    mkIf
    mkMerge
    ;

  cfg = config.host;
in {
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
