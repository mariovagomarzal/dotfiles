################################
# Justfile for the repository. #
################################
[private]
default:
    @just --list --unsorted

# Dotfiles setup recipes.
hostname := "$(hostname)"

[group("dotfiles")]
[doc('Rebuild a Darwin configuration with the given hostname.')]
darwin-rebuild HOSTNAME=hostname:
    @echo "Rebuilding the Darwin configuration for {{HOSTNAME}}..."
    sudo darwin-rebuild switch --flake ".#{{HOSTNAME}}"

alias dr := darwin-rebuild

# Development recipes.
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

alias fmt := format

[group("development")]
[doc("Generate the changelog.")]
[confirm]
changelog:
    @echo "Generating the changelog..."
    git-cliff

[group("development")]
[doc("Create a new version tag (based on the changelog content).")]
[confirm]
tag:
    #!/usr/bin/env bash
    set -euo pipefail
    version=$(grep -m 1 '^## \[' CHANGELOG.md | sed 's/^## \[\([^]]*\)\].*/\1/')
    if [ -z "$version" ]; then
        echo "Error: Could not determine the version from CHANGELOG.md"
        exit 1
    fi
    echo "Creating tag for version: $version"
    git tag -s "$version" -m "Version $version"
