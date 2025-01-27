#!/usr/bin/env bash

# This script focuses the target display based on the input argument ($1), with
# the following behavior:
#   - If the target is "next", focus the next display. If already on the last
#     display, wrap around to the first.
#   - If the target is "prev", focus the previous display. If already on the
#     first display, wrap around to the last.
#   - For any other input, it focuses the display specified by the argument
#     directly (e.g., display ID or name).

case $1 in
  next)
    yabai -m display --focus next || yabai -m display --focus first
    ;;
  prev)
    yabai -m display --focus prev || yabai -m display --focus last
    ;;
  *)
    yabai -m display --focus "$1"
    ;;
esac
