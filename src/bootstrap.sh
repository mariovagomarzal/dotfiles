#!/bin/bash
#
# Run the setup scripts and symlink the files of each package.
# NOTE: This script is meant to be run from the root of the dotfiles repo.


# Load utils
. "src/utils.sh"


# ┌─────────────────────────────┐
# │ Setup and symlink functions │
# └─────────────────────────────┘

# - - - - - - - - - - - - - - - - - - - - - -
# Run the `setup.sh` script of a given dir.
# Arguments:
#   $1. The dir to setup.
# Returns:
#   Exit code of the `setup.sh` script.
# - - - - - - - - - - - - - - - - - - - - - -
setup() {
    local -r dir="${1}"
    local exit_code=0

    # Check if the dir has a `setup.sh` script.
    if [[ -f "${dir}/setup.sh" ]]; then
        run_command "bash ${dir}/setup.sh" \
            "Setting up '${dir}'..." \
            "'${dir}' successfully setup." \
            "$'{dir}' failed to setup."
        exit_code=$?
    else
        print_warning "No 'setup.sh' script found for '${dir}'."
    fi

    return $exit_code
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Locate the `symlinks` folder of a given dir.
# Then, symlink each file assuming root of the symlink is the home dir
# and following the same folder structure as the `symlinks` folder.
# Arguments:
#   $1. The dir to symlink.
# Returns:
#   None.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
symlink() {
    local -r dir="${1}"
    local -r symlinks_dir="${dir}/symlinks"

    local relative_path=""
    local absolute_path=""

    # Check if the dir has a `symlinks` folder.
    if [[ -d "${symlinks_dir}" ]]; then
        # Loop through each file in the `symlinks` folder recursively.
        for file in $(find "${symlinks_dir}" -type f); do
            # Get the absolute path of the file of the target symlink.
            relative_path="${file#${symlinks_dir}/}"
            absolute_path="${HOME}/${relative_path}"

            # Create the symlink (note that we make $file absolute by prepending $DOTFILES)
            run_command "ln -sf ${DOTFILES}/${file} ${absolute_path}" \
                "Symlinking to '${absolute_path}'..." \
                "'${absolute_path}' successfully symlinked." \
                "'${absolute_path}' failed to symlink."
        done
    else
        print_warning "No 'symlinks' folder found for '${dir}'."
    fi
}


# ┌─────────────────────┐
# │ Bootstrap functions │
# └─────────────────────┘

# - - - - - - - - - - - - - - - - - - - -
# Setup and symlink a given dir.
# Arguments:
#   $1. The dir to bootstrap.
# Returns:
#   Exit code of the `setup.sh` script.
# - - - - - - - - - - - - - - - - - - - -
bootstrap() {
    local -r dir="${1}"
    local exit_code=0

    print_header "Bootstrapping '${dir}'"

    # Setup the dir.
    setup "${dir}"
    exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        # Symlink the dir.
        symlink "${dir}"
    else
        print_warning "Skipping symlinking of '${dir}' due to errors during setup."
    fi

    return $exit_code
}

# - - - - - - - - - - - - - - - - - - - - - - - 
# Bootstrap all dirs of the `BOOTSTRAP` array.
# Globals:
#   BOOTSTRAP: Array of dirs to bootstrap.
# Arguments:
#   None.
# Returns:
#   None.
# - - - - - - - - - - - - - - - - - - - - - - -
bootstrap_all() {
    print_main_header "Bootstrapping packages"

    for dir in "${BOOTSTRAP[@]}"; do
        bootstrap "${dir}"
    done
}


# ┌──────────────┐
# │ Main program │
# └──────────────┘
bootstrap_all
exit 0
