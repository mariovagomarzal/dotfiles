#!/usr/bin/env bash

# This script focuses the target space based on the input argument ($1), with
# the following behavior:
#   - If the target is "next", focus the next space. If already on the last
#     space, wrap around to the first.
#   - If the target is "prev", focus the previous space. If already on the
#     first space, wrap around to the last.
#   - If the target is a single digit (e.g., "2") and exceeds the total number
#     of spaces, focus the last space. Otherwise, focus the specified space.
#   - For any other input, it focuses the space specified by the argument
#     directly (e.g., space name or identifier).

total_spaces=$(yabai -m query --spaces --display | jq 'length')

case $1 in
  next)
    yabai -m space --focus next || yabai -m space --focus first
    ;;
  prev)
    yabai -m space --focus prev || yabai -m space --focus last
    ;;
  [0-9])
    if [ "$1" -gt "$total_spaces" ]; then
      yabai -m space --focus last
    else
      yabai -m space --focus "$1"
    fi
    ;;
  *)
    yabai -m space --focus "$1"
    ;;
esac
