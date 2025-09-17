#!/usr/bin/env bash

# This script moves the currently focused window to a different space based on
# the input argument ($1), with the following behavior:
#   - If the target is "new", it creates a new space (using an external script)
#     and moves the window to the newly created space (the last space).
#   - If the target is "next", it moves the window to the next space. If on the
#     last space, it wraps around and moves the window to the first space.
#   - If the target is "prev", it moves the window to the previous space. If on
#     the first space, it wraps around and moves the window to the last space.
#   - If the target is a number (e.g., [0-9]), it moves the window to the
#     specified space. If the number exceeds the total spaces available, it
#     defaults to moving the window to the last space.
#   - For any other input, it moves the window to the specified space directly.

total_spaces=$(yabai -m query --spaces --display | jq length)

case $1 in
  new)
    ./functions/manage-space.sh "create" && yabai -m window --space last
    ;;
  next)
    yabai -m window --space next || yabai -m window --space first
    ;;
  prev)
    yabai -m window --space prev || yabai -m window --space last
    ;;
  [0-9])
    if [ $1 -gt $total_spaces ]; then
      yabai -m window --space last
    else
      yabai -m window --space "$1"
    fi
    ;;
  *)
    yabai -m window --space "$1"
    ;;
esac
