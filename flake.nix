{
  description = "Mario's dotfiles with Nix";

  # Dependencies for the flake.
  inputs = {
    # flake-parts, a tool for modularizing flakes.
    flake-parts.url = "github:hercules-ci/flake-parts";

    # nixpkgs, the Nix packages collection.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # nur, the Nix User Repository.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin, the Nix configuration for macOS.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs-firefox-darwin, the Nixpkgs overlay for Firefox on macOS.
    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";

    # home-manager, the Nix configuration for user environments.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin, a color scheme for customizing programs.
    catppuccin.url = "github:catppuccin/nix";

    # devshell, a tool for creating development environments.
    devshell.url = "github:numtide/devshell";

    # pre-commit-hooks-nix, a tool for managing pre-commit hooks for Nix.
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };

  # The flake's outputs (managed with flake-parts).
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      # The `flake` attribute specifies raw flake attributes.
      # System configurations managed with this flake are defined here by
      # importing the `system-configs.nix` module.
      flake = import ./system-configs.nix inputs;

      # The `imports` attribute specifies the flake's submodules to be included.
      imports = [
        # Development environment module.
        ./development.nix

        # External modules.
        inputs.devshell.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
      ];
    };
}
