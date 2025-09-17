#!/usr/bin/env bash

# This script manages window closure based on the input argument ($1), with the
# following behavior:
#   - If the target is "-focus", it closes all windows in the current space that
#     do not have focus.
#   - For any other input, it closes the window specified by the argument (e.g.,
#     window ID or identifier).

not_focus_windows=$(
  yabai -m query --windows --space | jq '
    .[] 
    | select(."has-focus" == false) 
    | .id
  '
)

case $1 in
  "-focus")
    for window in $not_focus_windows; do
      yabai -m window --close $window
    done
    ;;
  *)
    yabai -m window --close $1
    ;;
esac
