{
  description = "Mario's dotfiles with Nix";

  # Dependencies for the flake.
  inputs = {
    # nixpkgs, the Nix packages collection.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # nur, the Nix User Repository.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # snowfall-lib, a library for Nix flakes.
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin, the Nix configuration for macOS.
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, the Nix configuration for user environments.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin, a color scheme for customizing programs.
    catppuccin.url = "github:catppuccin/nix";

    # devshell, a tool for creating development environments.
    devshell.url = "github:numtide/devshell";

    # git-hooks.nix, a tool for managing git hooks with Nix.
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
  };

  # The flake's outputs (managed with snowfall-lib).
  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;

      snowfall = {};

      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
        nur.overlays.default
        devshell.overlays.default
      ];

      homes.modules = with inputs; [
        catppuccin.homeModules.catppuccin
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };

      alias = {
        shells.default = "development";
      };
    };
}
