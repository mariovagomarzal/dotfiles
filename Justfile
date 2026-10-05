[private]
default:
    @just --list --unsorted

hostname := "$(hostname)"

[doc('Rebuild a Darwin configuration with the given hostname.')]
[group("dotfiles")]
darwin-rebuild HOSTNAME=hostname:
    @echo "Rebuilding the Darwin configuration for {{ HOSTNAME }}..."
    sudo darwin-rebuild switch --flake ".#{{ HOSTNAME }}"

alias dr := darwin-rebuild

experimental_features := "--extra-experimental-features \"nix-command flakes\""

[doc("Run flake checks.")]
[group("development")]
check:
    @echo "Running flake checks..."
    nix {{ experimental_features }} flake check

[doc("Format Nix code.")]
[group("development")]
format PATHS=".":
    @echo "Formatting Nix code..."
    nix {{ experimental_features }} fmt {{ PATHS }}

alias fmt := format

[confirm]
[doc("Generate the changelog.")]
[group("development")]
changelog:
    @echo "Generating the changelog..."
    git-cliff

[confirm]
[doc("Create a new version tag (based on the changelog content).")]
[group("development")]
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
