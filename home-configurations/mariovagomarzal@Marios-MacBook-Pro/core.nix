#######################################################
# Core home configuration and packages for this user. #
#######################################################
{
  pkgs,
  config,
  ...
}: {
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  # User information for home-manager.
  home = {
    homeDirectory = "/Users/${config.home.username}";

    # Supported version.
    stateVersion = "25.05";
  };

  # No-configuration packages.
  home.packages = with pkgs; [
    # Programming languages (or related).
    elan
    zulu
  ];

  # Minimal configuration-dependent programs and/or services.
  programs = {};
  services = {};
}
