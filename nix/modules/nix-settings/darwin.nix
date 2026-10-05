/**
Nix settings: flakes, trusted users, and weekly garbage collection and store
optimisation on Sundays at 15:00.
*/
_: {
  nix.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    allowed-users = ["*"];
    trusted-users = ["root" "@admin"];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    interval = [
      {
        Hour = 15;
        Minute = 0;
        Weekday = 7;
      }
    ];
  };

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
