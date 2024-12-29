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

  # Users configuration.
  users.users =
    lib.mapAttrs (
      username: _: {
        description = users.${username}.userInfo.userName;
        home = "/Users/${username}";
      }
    )
    users;

  # List of users managed by 'nix-darwin'.
  users.knownUsers = let
    nonAdminUsers =
      lib.filterAttrs (
        _: userInfo: !({isAdmin = false;} // userInfo).isAdmin
      )
      users;
  in
    lib.attrNames nonAdminUsers;
}
