#########################
# System configuration. #
#########################
{...}: {
  system = {
    # The `activationScripts` attribute defines scripts that are run any time
    # you boot the system or switch to a new configuration.
    activationScripts.postUserActivation.text = ''
      # The `activateSettings` will reload the user configuration without
      # needing to logout or reboot.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      # Dock settings.
      dock = {
        # Automatically hide and show the Dock.
        autohide = true;

        # Don't rearrange spaces based on most recent use.
        mru-spaces = false;

        system.defaults.dock.static-only = true;
      };
    };
  };
}
