#!/bin/bash

# Constants
declare -r DOTFILES="$HOME/.dotfiles"
declare -r LOG_FILE="$HOME/dotfiles.log"


# Formatted output functions
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
    print_in_green "  [✔] $1"
}

print_fail() {
    print_in_red "  [✖] $1"
}

print_warning() {
    print_in_yellow "  [!] $1"
}

print_header() {
    print_in_purple "\n • $1\n"
}


# Run a command with a spinner
show_spinner() {
    local -r pid="${1}"
    local -r message="${2}"

    local -r spin="-\|/"
    local i=0
    local blank=""
    

    while kill -0 "${pid}" &> /dev/null; do
        printf "\r  [%c] %s" \
            "${spin:i++%${#spin}:1}" \
            "${message}"
        sleep 0.1
    done

    blank="$(printf "%*s" $(( ${#message} + 6 )))"
    printf "\r${blank}\r"
}

# Usage: run_command <COMMAND> <MESSAGE> <SUCCESS_MESSAGE> <FAILURE_MESSAGE>
run_command() {
    local -r command="${1}"
    local -r message="${2}"
    local -r success_message="${3}"
    local -r failure_message="${4}"

    local pid=""
    local exit_code=0
    
    # into log file
    eval "${command}" &> "${LOG_FILE}" &
        pid=$!

    show_spinner "${pid}" "${message}"

    wait "${pid}" &> /dev/null
    exit_code=$?

    if [ $exit_code -ne 0 ]; then
        print_fail "${failure_message}"
    else
        print_success "${success_message}"
    fi

    return $exit_code
}
