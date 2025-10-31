####################################
# Nix core settings Darwin module. #
####################################
{...}: {
  # Enable the Nix garbage collector.
  nix.gc = {
    automatic = true;
    interval = [
      {
        Hour = 15;
        Minute = 0;
        Weekday = 7;
      }
    ];
  };

  # Enable Nix store optimisation.
  nix.optimise = {
    automatic = true;
    interval = [
      {
        Hour = 15;
        Minute = 0;
        Weekday = 7;
      }
    ];
  };
}
