#!/bin/bash
#
# Run the installers of each package.
# NOTE: This script is meant to be run from the root of the dotfiles repo.


# Load utils
. "src/utils.sh"


# ┌───────────────────┐
# │ Install functions │
# └───────────────────┘

# - - - - - - - - - - - - - - - - - - - - - - -
# Run the `install.sh` script of a given dir.
# Arguments:
#   $1. The dir to install.
# Returns:
#   Exit code of the `install.sh` script.
# - - - - - - - - - - - - - - - - - - - - - - -
install() {
    local -r dir="${1}"
    local exit_code=0

    # Check if the dir has an `install.sh` script.
    if [[ -f "${dir}/install.sh" ]]; then
        run_command "bash ${dir}/install.sh" \
            "Installing '${dir}'..." \
            "'${dir}' successfully installed." \
            "$'{dir}' failed to install."
        exit_code=$?
    else
        print_warning "No 'install.sh' script found for '${dir}'."
    fi

    return $exit_code
}

# - - - - - - - - - - - - - - - - - - - - - -
# Install all dirs of the `INSTALLS` array.
# Arguments:
#   None.
# Returns:
#   None.
# - - - - - - - - - - - - - - - - - - - - - -
install_all() {
    print_header "Installing packages"

    for dir in "${INSTALLS[@]}"; do
        install "${dir}"
    done
}


# ┌──────────────┐
# │ Main program │
# └──────────────┘

install_all
exit 0
