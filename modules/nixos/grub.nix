######################
# GRUB NixOS module. #
######################
{...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;

      # Build GRUB with EFI support.
      efiSupport = true;

      # Generate the boot menu, but don't install GRUB in any device.
      device = "nodev";

      # Enable OSProber for automatically discovering extra OS.
      useOSProber = true;
    };
  };
}
