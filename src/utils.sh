#!/bin/bash
#
# Some helper functions for the dotfiles.


# ┌───────────┐
# │ Constants │
# └───────────┘
declare -r DOTFILES="$HOME/Projects/dotfiles"
declare -r LOG_FILE="$DOTFILES/dotfiles.log"

declare -r INSTALL=(
    "homebrew"
)
declare -r BOOTSTRAP=(
    "homebrew"
)

declare -r SMALL_TAB="   "
declare -r LARGE_TAB="     "


# ┌────────────────────────────┐
# │ Formatted output functions │
# └────────────────────────────┘
print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_in_red() {
    print_in_color "$1\n" 1
}

print_in_green() {
    print_in_color "$1\n" 2
}

print_in_yellow() {
    print_in_color "$1\n" 3
}

print_in_purple() {
    print_in_color "$1\n" 5
}

print_success() {
    print_in_green "${LARGE_TAB}[✔] $1"
}

print_fail() {
    print_in_red "${LARGE_TAB}[✖] $1"
}

print_warning() {
    print_in_yellow "${LARGE_TAB}[!] $1"
}

print_main_header() {
    print_in_purple "\n • $1\n"
}

print_header() {
    print_in_purple "${SMALL_TAB}$1\n"
}


# ┌─────────────────────────────┐
# │ Run commands with a spinner │
# └─────────────────────────────┘

# - - - - - - - - - - - - - - - - - - - - - - -
# Show a spinner while a command is running.
# Arguments:
#   $1. Pid of the running command.
#   $2. Message to display.
# Returns:
#   None.
# - - - - - - - - - - - - - - - - - - - - - - -
show_spinner() {
    local -r pid="${1}"
    local -r message="${2}"

    local -r spin="-\|/"
    local i=0
    local blank=""
    
    
    # Print the message until the command completes.
    while kill -0 "${pid}" &> /dev/null; do
        printf "\r  [%c] %s" \
            "${spin:i++%${#spin}:1}" \
            "${message}"
        sleep 0.1
    done

    # Create a blank space over the spinner text.
    blank="$(printf "%*s" $(( ${#message} + 6 )))"
    printf "\r${blank}\r"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Run a command and show a spinnner while it's running.
# Then, show a success or failure message.
# Arguments:
#   $1. Command to run.
#   $2. Message to display while the command is running.
#   $3. Message to display on success.
#   $4. Message to display on failure.
# Returns:
#   Exit code of the command.
# - - - - - - - - - - - - - - - - - - - - - - - - - - -
run_command() {
    local -r command="${1}"
    local -r message="${2}"
    local -r success_message="${3}"
    local -r failure_message="${4}"

    local pid=""
    local exit_code=0
    
    # Run the command in the background and store its pid.
    # Then, show a spinner while the command is running.
    eval "${command}" \
        &> "${LOG_FILE}" \
        & pid=$!

    show_spinner "${pid}" "${message}"

    # Wait for the command to no longer be executing
    # and then get its exit code.
    wait "${pid}" &> /dev/null
    exit_code=$?

    # Show the success or failure message.
    if [ $exit_code -ne 0 ]; then
        print_fail "${failure_message}"
    else
        print_success "${success_message}"
    fi

    return $exit_code
}
