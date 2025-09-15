#!/usr/bin/env bash

# This script swaps the currently focused window with another window in the
# specified direction, based on the input argument ($1), with the following
# behavior:
#   - If the target is "west", "east", "north", or "south", it attempts to swap
#     the window with the window in the specified direction. If no window exists
#     in that direction, it tries an alternate direction, and if still
#     unsuccessful, it moves the window to the adjacent space ("prev" or
#     "next").
#   - If the target is "next", it attempts to swap the window with the next
#     window in the stack. If unsuccessful, it swaps with the first window.
#   - If the target is "prev", it attempts to swap the window with the previous
#     window in the stack. If unsuccessful, it swaps with the last window.
#   - For any other input, it attempts to swap the window with the specified
#     window directly (e.g., window ID or name).

case $1 in
  west)
    yabai -m window --swap west || yabai -m window --swap north \
                                || source ./functions/move-window.sh "prev"
    ;;
  east)
    yabai -m window --swap east || yabai -m window --swap south \
                                || source ./functions/move-window.sh "next"
    ;;
  north)
    yabai -m window --swap north || yabai -m window --swap west \
                                 || source ./functions/move-window.sh "prev"
    ;;
  south)
    yabai -m window --swap south || yabai -m window --swap east \
                                 || source ./functions/move-window.sh "next"
    ;;
  next)
    yabai -m window --swap next || yabai -m window --swap first
    ;;
  prev)
    yabai -m window --swap prev || yabai -m window --swap last
    ;;
  *)
    yabai -m window --swap "$1"
    ;;
esac
