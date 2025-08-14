#################################
# Host and users configuration. #
#################################
{
  lib,
  hostname,
  computerName,
  users,
  ...
}: {
  # Host configuration.
  networking.hostName = hostname;
  networking.computerName = computerName;

  system.defaults.smb = {
    NetBIOSName = hostname;
    ServerDescription = hostname;
  };

  # Users configuration.
  system.primaryUser = let
    primaryUsersAttr =
      lib.filterAttrs (
        _: user:
          (user.userInfo ? "isPrimaryUser")
          && user.userInfo.isPrimaryUser
      )
      users;
    primaryUsers = lib.attrNames primaryUsersAttr;
  in
    if lib.length primaryUsers == 1
    then lib.head primaryUsers
    else
      throw ''
        There must be exactly one primary user,
        but found ${lib.length primaryUsers}.
      '';

  users.users =
    lib.mapAttrs (
      username: _: {
        description = users.${username}.userInfo.userName;
        home = "/Users/${username}";
      }
    )
    users;
}
