#!/usr/bin/env bash

# This script toggles a specified window property ($1) related to fullscreen,
# with the following behavior:
#   - If the target is "native", it toggles native fullscreen mode for the
#     focused window. If the space was not previously in fullscreen mode, i.e.,
#     the window is entering fullscreen, it moves the space next to the space
#     it belongs to.
#   - For any other input, it toggles the specified window property (e.g.,
#     "zoom-fullscreen").

current_space=$(yabai -m query --spaces --space | jq '.index')
is_fullscreen=$(yabai -m query --spaces --space | jq '."is-native-fullscreen"')

case $1 in
  "native")
    yabai -m window --toggle native-fullscreen
    if [ $is_fullscreen != "true" ]; then
      sleep 1
      ./functions/move-space.sh $((current_space + 1))
    fi
    ;;
  *)
    yabai -m window --toggle $1
    ;;
esac
