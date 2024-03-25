# Justfile for the repository.

[private]
default:
    @just --list --unsorted

########################
# Development recipes. #
########################

experimental_features := "--extra-experimental-features \"nix-command flakes\""

# Setup the development environment (outside the devshells).
setup-env:
    @echo "Installing pre-commit hooks..."
    @_pre-commit-install

# Run flake checks.
check:
    @echo "Running flake checks..."
    nix {{experimental_features}} flake check

# Format Nix code.
format paths=".":
    @echo "Formatting Nix code..."
    nix {{experimental_features}} fmt {{paths}}
