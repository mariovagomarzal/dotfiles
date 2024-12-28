#####################################################
# Development environment tools and configurations. #
#####################################################
{...}: {
  # Define the systems where the development environment is available.
  systems = [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  # Define the development environment configurations.
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
        default_stages = ["pre-commit"];
        hooks = {
          # Enable the Alejandra pre-commit hook.
          alejandra.enable = true;

          # Enable the markdownlint pre-commit hook.
          markdownlint = {
            enable = true;
            settings.configuration = {
              # Allow to exceed the maximum line length.
              "MD013" = false;
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
        name = "dotfiles-dev";
        motd = ''
          {2}{bold}[i] Development shell for Mario's dotfiles repository.\
          {reset}
          $(type -p menu &> /dev/null && menu)
        '';
        startup."setup-env".text = ''
          # Install pre-commit hooks.
          ${config.pre-commit.installationScript}
        '';
      };

      # Define the available commands for the shell.
      commands = [
        # Add the Just command runner to the development shell.
        {
          package = pkgs.just;
          help = "Type `just` to see the available recipes.";
        }
      ];
    };
  };
}
