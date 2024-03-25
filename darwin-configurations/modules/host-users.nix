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
  users.knownUsers = [userName];
  nix.settigns.trustedUsers = [userName];

  users.users.${userName} = {
    description = "User ${userName}";
    home = "/Users/${userName}";
  };
}
