# Justfile for the repository.
[private]
default:
    @just --list --unsorted

###########################
# Dotfiles setup recipes. #
###########################
hostname := "$(hostname)"

[group("dotfiles")]
[doc('Rebuild a Darwin configuration with the given hostname.')]
darwin-rebuild HOSTNAME=hostname:
    @echo "Rebuilding the Darwin configuration for {{HOSTNAME}}..."
    sudo darwin-rebuild switch --flake ".#{{HOSTNAME}}"

alias dr := darwin-rebuild

########################
# Development recipes. #
########################
experimental_features := "--extra-experimental-features \"nix-command flakes\""

[group("development")]
[doc("Run flake checks.")]
check:
    @echo "Running flake checks..."
    nix {{experimental_features}} flake check

[group("development")]
[doc("Format Nix code.")]
format PATHS=".":
    @echo "Formatting Nix code..."
    nix {{experimental_features}} fmt {{PATHS}}
