#!/usr/bin/env bash

# This script manages spaces by creating or destroying them based on the input
# argument ($1), with the following behavior:
#   - If the target is "create", it creates a new space if there are fewer than
#     9 spaces. If the limit of 9 spaces is reached, it outputs an error and
#     exits with a non-zero status. Note that spaces with fullscreen windows are
#     not counted.
#   - If the target is "destroy", it destroys the current space unless it is
#     space 1. Attempting to destroy space 1 results in an error message and a
#     non-zero exit status.
#   - If a second argument ($2) is provided, it calls an external script to
#     focus the specified space.

total_spaces=$(
  yabai -m query --spaces --display | 
  jq '
    [ .[] 
      | select(."is-native-fullscreen" == false)
    ] 
    | length
  '
)
current_space=$(yabai -m query --spaces --space | jq '.index')

case $1 in
  create)
    if [ $total_spaces -lt 9 ]; then
      yabai -m space --create
    else
      echo "Cannot create more than 9 spaces" >> /dev/stderr
      exit 1
    fi
    ;;
  destroy)
    if [ $current_space -ne 1 ]; then
      yabai -m space --destroy
    else
      echo "Cannot destroy space 1" >> /dev/stderr
      exit 1
    fi
    ;;
esac

if [ $2 ]; then
  source ./functions/focus-space.sh "$2"
fi
