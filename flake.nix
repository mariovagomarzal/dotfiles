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

    # blueprint, a library for Nix flakes.
    blueprint = {
      url = "github:numtide/blueprint";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin, the Nix configuration for macOS.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, the Nix configuration for user environments.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin, a color scheme for customizing programs.
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # devshell, a tool for creating development environments.
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # git-hooks.nix, a tool for managing git hooks with Nix.
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The flake's outputs (managed by blueprint).
  outputs = inputs:
    inputs.blueprint {
      inherit inputs;

      nixpkgs.config = {
        allowUnfree = true;
      };

      nixpkgs.overlays = with inputs; [
        nur.overlays.default
        devshell.overlays.default
        (import ./overlays/obsidian-builders)
      ];
    };
}
