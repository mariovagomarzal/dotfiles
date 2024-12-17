######################################
# System configurations definitions. #
######################################
inputs @ {
  nix-darwin,
  home-manager,
  ...
}: {
  darwinConfigurations = {
    # Mario's MacBook Pro configuration.
    "Marios-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs =
        {
          hostName = "Marios-MacBook-Pro";
          userName = "mariovagomarzal";
          userEmail = "mariovagomarzal@gmail.com";
        }
        // inputs;
      modules = [
        # Module for the Nix configuration itself.
        ./darwin-configurations/nix-core.nix

        # Module for the host and users configuration.
        ./darwin-configurations/Marios-MacBook-Pro/host-users.nix

        # Module with the system configuration.
        ./darwin-configurations/Marios-MacBook-Pro/system.nix

        # Module with the packages to install and manage.
        ./darwin-configurations/Marios-MacBook-Pro/packages.nix

        # Home Manager module.
        home-manager.darwinModules.home-manager
        {
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            userName = "mariovagomarzal";
            userEmail = "mariovagomarzal@gmail.com";
          };
          home-manager.users."mariovagomarzal" = {
            imports = [
              # Core packages and utilities (with no special configuration).
              ./home-configurations/mariovagomarzal/core.nix

              # SSH agent configuration.
              ./home-configurations/ssh.nix

              # Fish shell configuration.
              ./home-configurations/fish.nix

              # Starship prompt configuration.
              ./home-configurations/starship.nix

              # Alacrity terminal configuration.
              ./home-configurations/alacritty.nix

              # Git configuration.
              ./home-configurations/git.nix

              # Yabai window manager configuration.
              ./home-configurations/yabai.nix

              # Skhd hotkey daemon configuration.
              ./home-configurations/skhd.nix
            ];
          };
        }
      ];
    };
  };
}
