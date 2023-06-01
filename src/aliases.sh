#!/bin/bash
#
# Source the aliases of each package.
# NOTE: This script is meant to be run by a `.zshrc` script (or similar).
# NOTE: This script is meant to be run from the root of the dotfiles repo.


# Load utils
. "src/utils.sh"


# ┌──────────────────────────┐
# │ Source aliases functions │
# └──────────────────────────┘

# -
# Source the aliases of a given dir.
# Arguments:
#   $1. The dir to source.
# Returns:
#   Exit code of the `aliases.sh` script.
# -
source_aliases() {
    local -r dir="${1}"
    local exit_code=0

    # Check if the dir has an `aliases.sh` script.
    if [[ -f "${dir}/aliases.sh" ]]; then
        run_command "source \"${dir}/aliases.sh\"" \
            "Sourcing aliases for '${dir}'..." \
            "Aliases for '${dir}' sourced successfully." \
            "Failed to source aliases for '${dir}'."
        exit_code=$?
    else
        print_warning "No 'aliases.sh' script found for '${dir}'."
    fi

    return $exit_code
}

# -
# Source the aliases of all dirs of the `ALIASES` array.
# Globals:
#   ALIASES: Array of dirs to source.
# Arguments:
#   None.
# Returns:
#   None.
# -
source_all_aliases() {
    for dir in "${ALIASES[@]}"; do
        source_aliases "${dir}"
    done
}


# ┌──────────────┐
# │ Main program │
# └──────────────┘
main () {
    print_main_header "Sourcing aliases"
    source_all_aliases
    exit 0
}

main
