#####################################################
# Development environment tools and configurations. #
#####################################################
{...}: {
  # The `systems` attribute is a list of supported systems used by the
  # `perSystem` attribute to define system-specific attributes of the flake.
  systems = [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  # The `perSystem` attribute defines system-specific attributes of the flake,
  # making the following tools and configurations available on all systems
  # defined in the `systems` attribute.
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    # Use Alejandra as the default Nix code formatter.
    formatter = pkgs.alejandra;

    # Configure the pre-commit hooks for this repository.
    pre-commit = {
      check.enable = true;
      settings = {
        default_stages = ["commit"];
        hooks = {
          # Enable the Alejandra pre-commit hook.
          alejandra.enable = true;

          # Enable the markdownlint pre-commit hook.
          markdownlint = {
            enable = true;
            settings.config = {
              # Allow multiple headers with the same content.
              "MD024" = false;
            };
          };
        };
      };
    };

    # Configure the default development shell with devshell.
    devshells.default = {
      # Configure the shell information.
      devshell = {
        name = "dotfiles";
        motd = ''
          {2}{bold}[i] Development shell for Mario's dotfiles repository.
          {reset}
          {3}[!] Don't use commands from the internal category.{reset}
          $(type -p menu &> /dev/null && menu)
        '';
      };

      # Define the available commands for the shell.
      commands = [
        # Add the Just command runner to the development shell.
        {
          package = pkgs.just;
          help = "Type `just` to see the available recipes.";
        }

        # Add an internal command to install pre-commit hooks.
        {
          name = "_pre-commit-install";
          command = config.pre-commit.installationScript;
          help = "Internal command to install pre-commit hooks.";
          category = "internal";
        }
      ];
    };
  };
}
