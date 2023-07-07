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
    local exit_code=0
    local install=0

    if [[ ! -d "/Library/Developer/CommandLineTools" ]]; then
        print_info "Xcode developer line tools not installed."
        ask_confirmation "Do you want to install them?"
        install=$?
        if [[ $install -eq 0 ]]; then
            print_header "Installing Xcode developer line tools"
            run_command "xcode-select --install" \
                "Installing Xcode developer line tools..." \
                "Xcode developer line tools successfully installed." \
                "Xcode developer line tools failed to install."
            exit_code=$?
        else 
            print_error "Xcode developer line tools not installed."
            exit_code=1
        fi
    else
        print_success "Xcode developer line tools already installed."
    fi

    return $exit_code
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
    local exit_code=0
    local install=0

    if [[ ! -d "${DOTFILES_TARGET}" ]]; then
        print_info "Dotfiles repository does not exist locally at ${DOTFILES_TARGET}."
        ask_confirmation "Do you want to clone it?"
        install=$?

        if [[ $install -eq 0 ]]; then
            run_command "git clone ${DOTFILES_URL} ${DOTFILES_TARGET}" \
                "Cloning dotfiles repository..." \
                "Dotfiles repository successfully cloned." \
                "Dotfiles repository failed to clone."
            exit_code=$?
        else
            print_error "Dotfiles repository not cloned."
            exit_code=1
        fi
    else
        print_success "Dotfiles repository already cloned."
    fi

    return $exit_code
}


# ┌──────────────┐
# │ Main program │
# └──────────────┘
main() {
    local installs=0
    local installs_exit=1
    local bootstraps=0
    local bootstraps_exit=1

    load_utils || exit 1

    print_main_header "Preparing files and tools for setup"

    install_xcode_dev_tools || exit 1
    clone_repository || exit 1

    cd "${DOTFILES_TARGET}"

    # Installations
    printf "\n\n"
    ask_confirmation "Do you want to proceed with the installations?"
    printf "\n"
    installs=$?
    if [[ $installs -eq 0 ]]; then
        bash src/install.sh
        installs_exit=$?
    fi

    # Bootstraps
    printf "\n\n"
    if [[ $installs_exit -eq 1 ]]; then
        print_info "Installations skipped or some of them failed."
    fi

    ask_confirmation "Do you want to proceed with the bootstraps?"
    printf "\n"
    bootstraps=$?
    if [[ $bootstraps -eq 0 ]]; then
        bash src/bootstrap.sh
        bootstraps_exit=$?
    fi

    # Exit with 0 if all the installations and bootstraps were successful, 1 if any of them failed.
    exit $((installs_exit + bootstraps_exit))
}

main
