#################################
# Host and users configuration. #
#################################
{
  lib,
  hostname,
  users,
  ...
}: {
  # Host name configuration.
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Users configuration.
  users.users =
    lib.mapAttrs (
      username: _: {
        description = "User ${username}";
        home = "/Users/${username}";
      }
    )
    users;

  nix.settings.trusted-users = ["root"] ++ (lib.attrNames users);
}
