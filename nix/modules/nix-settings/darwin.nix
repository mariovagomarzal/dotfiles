/**
Nix settings: flakes, trusted users, a GitHub token, and weekly garbage
collection and store optimisation on Sundays at 15:00.

The token, read-only and for public repositories, lifts GitHub's API rate
limit when Nix fetches flake inputs. Fetching runs in the user's own `nix`
process, so the rendered `access-tokens` line belongs to the primary user.
*/
{config, ...}: {
  nix.enable = true;

  sops.secrets."nix-settings/github-token" = {
    sopsFile = ./secrets.yaml;
    key = "github-token";
  };

  sops.templates."nix-access-tokens" = {
    content = "access-tokens = github.com=${config.sops.placeholder."nix-settings/github-token"}";
    owner = config.system.primaryUser;
  };

  # `!include` skips the file while it does not exist yet, such as before the first activation.
  nix.extraOptions = "!include ${config.sops.templates."nix-access-tokens".path}";

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
