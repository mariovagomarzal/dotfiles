#!/bin/bash
#
# Run the shell scripts of each package and create the symlinks.
# NOTE: This script is meant to be run from the root of the dotfiles repo.


# Load utils
. "src/utils.sh"


# ┌─────────────────┐
# │ Setup functions │
# └─────────────────┘

# -
# Run a given setup script
# Arguments:
#   $1. The setup script to run.
# Returns:
#   Exit code of the `.sh` script.
# -
run_script() {
    local -r script="${1}"

    run_command "bash ${script}" \
        "Running '${script}'..." \
        "'${script}' successfully ran." \
        "'${script}' failed to run."

    return $?
}

# -
# Find all the `.sh` scripts of a given folder different
# from `intall.sh` and `aliases.sh`.
# Arguments:
#   $1. The folder to search.
# Returns:
#   An array of `.sh` scripts.
# -
find_scripts() {
    local -r dir="${1}"
    local -a scripts=()

    while IFS= read -r -d '' file; do
        if [[ "${file}" != "${dir}/install.sh" ]] && \
           [[ "${file}" != "${dir}/aliases.sh" ]]; then
            scripts+=("${file}")
        fi
    done < <(find "${dir}" -type f -name "*.sh" -print0)

    printf '%s\n' "${scripts[@]}"
}

# -
# Run all the `.sh` scripts of a given folder.
# Arguments:
#   $1. The folder to search.
# Returns:
#   None.
# -
run_all_dir_scripts() {
    local -r dir="${1}"

    for script in $(find_scripts "${dir}"); do
        run_script "${script}"
    done
}

# -
# Run all the `.sh` scripts of the BOOTSTRAP array.
# Globals:
#   BOOTSTRAP: Array of dirs to run the `.sh` scripts.
# Arguments:
#   None.
# Returns:
#   None.
# -
run_all() {
    print_main_header "Running bootstrap scripts"

    for dir in "${BOOTSTRAP[@]}"; do
        print_header "Running scripts of '${dir}'"
        run_all_dir_scripts "${dir}"
    done
}
