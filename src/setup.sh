#!/bin/bash
#
# Setup a new macOS machine.
# NOTE: Make sure you know what you are doing before running this script.


# ┌───────────┐
# │ Constants │
# └───────────┘
declare -r DOTFILES_REPO="mariovagomarzal/dotfiles"
declare -r DOTFILES_URL="https://github.com/${DOTFILES_REPO}.git"


# ┌────────────────────────────────┐
# │ Load the utils from the remote │
# └────────────────────────────────┘
# TODO


# ┌──────────────────────────────────────────────┐
# │ Install Xcode developer line tools if needed │
# └──────────────────────────────────────────────┘
install_xcode_dev_tools() {
    if [[ ! -d "/Library/Developer/CommandLineTools" ]]; then
        xcode-select --install &> /dev/null
        return $?
    else
        printf "Xcode developer tools already installed.\n"
        return 0
    fi
}


# ┌──────────────────────┐
# │ Clone the repository │
# └──────────────────────┘
clone_repository() {
    if [[ ! -d "${DOTFILES}" ]]; then
        printf "Cloning dotfiles...\n"
        git clone --quiet "${DOTFILES_URL}" "${DOTFILES}"
        return $?
    else
        printf "Dotfiles already cloned.\n"
        return 0
    fi
}


# ┌──────────────┐
# │ Main program │
# └──────────────┘
main() {
    install_xcode_dev_tools
    if [[ $? -ne 0 ]]; then
        printf "Error installing Xcode developer tools.\n"
        exit 1
    fi

    clone_repository
    if [[ $? -ne 0 ]]; then
        printf "Error cloning dotfiles.\n"
        exit 1
    fi

    # 'cd' into the dotfiles repo abd run the install and bootstrap scripts.
    cd "${DOTFILES}"
    bash "src/install.sh"
    bash "src/bootstrap.sh"
}

main
exit 0
