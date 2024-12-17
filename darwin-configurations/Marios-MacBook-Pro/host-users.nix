#################################
# Host and users configuration. #
#################################
{
  hostName,
  userName,
  ...
}: {
  # Host name configuration.
  networking.hostName = hostName;
  networking.computerName = hostName;
  system.defaults.smb.NetBIOSName = hostName;

  # Users configuration.
  users.users.${userName} = {
    description = "User ${userName}";
    home = "/Users/${userName}";
  };

  nix.settings.trusted-users = [userName];
}
