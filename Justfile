# Justfile for the repository.

[private]
default:
    @just --list --unsorted

###########################
# Dotfiles setup recipes. #
###########################

hostname := "$(hostname)"

alias dr := darwin-rebuild

# Rebuild a Darwin configuration with the given hostname.
darwin-rebuild HOSTNAME=hostname:
    @echo "Rebuilding the Darwin configuration..."
    sudo darwin-rebuild switch --flake ".#{{HOSTNAME}}"

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
format PATHS=".":
    @echo "Formatting Nix code..."
    nix {{experimental_features}} fmt {{PATHS}}
