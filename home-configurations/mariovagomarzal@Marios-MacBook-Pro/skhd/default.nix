####################################################
# Skhd hotkey daemon configuratuion for this user. #
####################################################
{
  config,
  pkgs,
  ...
}: {
  tmpServices.skhd = {
    enable = true;

    # Skhd configuration directory.
    configSource = ./config;

    # Additional packages to add to the Skhd launchd agent's PATH.
    extraPackages = [
      config.services.yabai.package
      pkgs.jq
    ];

    # Additional environment variables to add to the Skhd launchd agent's
    # environment.
    extraEnvironment = {
      SHELL = "${pkgs.bash}/bin/bash";
    };
  };
}
