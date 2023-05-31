#!/bin/bash
#
# Setup a new macOS machine.
# NOTE: Make sure you know what you are doing before running this script.


# ┌───────────┐
# │ Constants │
# └───────────┘
declare -r DOTFILES_REPO="mariovagomarzal/dotfiles"
declare -r DOTFILES_URL="https://github.com/${DOTFILES_REPO}.git"
# TODO: Change develop branch to main once it is stable.
declare -r UTILS_URL="https://raw.githubusercontent.com/${DOTFILES_REPO}/develop/src/utils.sh"
declare -r DOTFILES_TARGET="${HOME}/Projects/dotfiles"


# ┌────────────┐
# │ Load utils │
# └────────────┘

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Load the utils from the remote if they are not available locally.
# From now on, the functions will use functions and constants from
# the utils file.
# Arguments:
#   None.
# Returns:
#   0 if the utils were loaded successfully, 1 otherwise.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
load_utils() {
    local -r tmp_file="$(mktemp /tmp/XXXXX)"
    local -r utils_file="${DOTFILES_TARGET}/src/utils.sh"

    if [[ ! -f "${utils_file}" ]]; then
        curl --silent --output "${tmp_file}" "${UTILS_URL}"
        exit_code=$?
        . "${tmp_file}"
    else
        . "${utils_file}"
    fi

    return $exit_code
}


# ┌────────────────────────────────────┐
# │ Install Xcode developer line tools │
# └────────────────────────────────────┘

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install the Xcode developer line tools if they are not installed.
# Arguments:
#   None.
# Returns:
#   0 if the Xcode developer line tools were installed successfully,
#   1 otherwise.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
install_xcode_dev_tools() {
    if [[ ! -d "/Library/Developer/CommandLineTools" ]]; then
        print_header "Installing Xcode developer line tools"
        run_command "xcode-select --install" \
            "Installing Xcode developer line tools..." \
            "Xcode developer line tools successfully installed." \
            "Xcode developer line tools failed to install."
        return $?
    else
        print_success "Xcode developer line tools already installed."
        return 0
    fi
}


# ┌──────────────────────┐
# │ Clone the repository │
# └──────────────────────┘

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Clone the dotfiles repository if it is not cloned.
# Arguments:
#   None.
# Returns:
#   0 if the dotfiles repository was cloned successfully, 
#   1 otherwise.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
clone_repository() {
    if [[ ! -d "${DOTFILES_TARGET}" ]]; then
        print_header "Cloning dotfiles repository"
        run_command "git clone ${DOTFILES_URL} ${DOTFILES_TARGET}" \
            "Cloning dotfiles repository..." \
            "Dotfiles repository successfully cloned." \
            "Dotfiles repository failed to clone."
        return $?
    else
        print_success "Dotfiles repository already cloned."
        return 0
    fi
}


# ┌──────────────┐
# │ Main program │
# └──────────────┘
main() {
    load_utils || exit 1

    print_main_header "Setting up macOS machine"

    # FIXME: Constants from utils are not available and custom prints don't respect format.
    install_xcode_dev_tools || exit 1
    clone_repository || exit 1

    cd "${DOTFILES_TARGET}"
    bash src/install.sh
    bash src/bootstrap.sh

    exit 0
}

main
