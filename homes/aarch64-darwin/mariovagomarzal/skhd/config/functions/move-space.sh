#!/usr/bin/env bash

# This script moves the current space based on the input argument ($1), with
# the following behavior:
#   - If the target is "next", it moves the current space to the next position.
#     If on space 1, it outputs an error and exits. If moving to the next space
#     fails, it defaults to moving to space 2.
#   - If the target is "prev", it moves the current space to the previous
#     position. If on space 1, it outputs an error and exits. If on space 2,
#     it wraps around to the last space.
#   - If the target is a number (e.g., [0-9]), it moves the current space to
#     the specified position unless either the current space or the target space
#     is space 1. Attempting to move space 1 results in an error and exit.
#   - For any other input, it moves the current space to the specified position
#     without additional checks.

current_space=$(yabai -m query --spaces --space | jq '.index')

error_moving_first_space () {
  echo "Space 1 cannot be moved" >> /dev/stderr
  exit 1
}

case $1 in
  next)
    if [ $current_space -eq 1 ]; then
      error_moving_first_space
    else
      yabai -m space --move next || yabai -m space --move 2
    fi
    ;;
  prev)
    if [ $current_space -eq 1 ]; then
      error_moving_first_space
    elif [ $current_space -eq 2 ]; then
      yabai -m space --move last
    else
      yabai -m space --move prev
    fi
    ;;
  [0-9])
    if [ $1 -ne 1 ] && [ $current_space -ne 1 ]; then
      yabai -m space --move $1
    else
      error_moving_first_space
    fi
    ;;
  *)
    yabai -m space --move $1
    ;;
esac
