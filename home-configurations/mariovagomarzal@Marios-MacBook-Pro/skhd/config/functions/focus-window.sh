#!/usr/bin/env bash

# This script focuses the target window based on the input argument ($1), with
# the following behavior:
#   - If the target is "west", "east", "north", or "south", it attempts to focus
#     the window in the specified direction. If no window exists in that 
#     direction, it tries an alternate direction, and if still unsuccessful,
#     it switches to the adjacent space ("prev" or "next").
#   - If the target is "next", focus the next window. If already on the last
#     window, wrap around to the first.
#   - If the target is "prev", focus the previous window. If already on the
#     first window, wrap around to the last.
#   - For any other input, it directly focuses the window specified by the
#     argument (e.g., window ID or identifier).

case $1 in
  west)
    yabai -m window --focus west || yabai -m window --focus north \
                                 || source ./functions/focus-space.sh "prev"
    ;;
  east)
    yabai -m window --focus east || yabai -m window --focus south \
                                 || source ./functions/focus-space.sh "next"
    ;;
  north)
    yabai -m window --focus north || yabai -m window --focus west \
                                  || source ./functions/focus-space.sh "prev"
    ;;
  south)
    yabai -m window --focus south || yabai -m window --focus east \
                                  || source ./functions/focus-space.sh "next"
    ;;
  next)
    yabai -m window --focus next || yabai -m window --focus first
    ;;
  prev)
    yabai -m window --focus prev || yabai -m window --focus last
    ;;
  *)
    yabai -m window --focus "$1"
    ;;
esac
