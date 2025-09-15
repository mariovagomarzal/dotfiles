#!/usr/bin/env bash

# This script resizes the currently focused window in Yabai based on the input
# arguments. It includes a helper function `get_step` to determine the resizing
# step size based on user input. The script supports various resizing modes
# with the following behavior:
# 
# Arguments:
#   - $1: Specifies the resize direction or action. Possible values include:
#     - "left" or "right": Resize the window horizontally by the step size.
#     - "top" or "bottom": Resize the window vertically by the step size.
#     - "top_left", "top_right", "bottom_left", or "bottom_right": Resize the
#       window diagonally by the step size in both dimensions.
#     - "corners": Adjust both top-left and bottom-right corners. Shrinks the
#       window by half a step from the top-left and expands it by half a step
#       at the bottom-right.
#     - Any other value: Resize the window using explicit dimensions passed as
#       $2 (width step) and $3 (height step).
#
#   - $2: Step size or custom value used for resizing (required for some cases).
#   - $3: Optional height step for resizing in custom mode.
#
# Behavior:
#   - The `get_step` function interprets common step size values:
#       * "small" or "-small": Uses a predefined small step of 10 (positive or
#         negative).
#       * "normal" or "-normal": Uses a predefined normal step of 30 (positive
#         or negative).
#       * Any other value: Directly uses the input as the step size.
#   - If "corners" is selected, it calculates half of the step size to adjust
#     the corners appropriately.

get_step () {
  local step_size=$1
  local small_step="10"
  local normal_step="30"

  if [ "$step_size" = "small" ]; then
    echo "$small_step"
  elif [ "$step_size" = "-small" ]; then
    echo "-$small_step"
  elif [ "$step_size" = "normal" ]; then
    echo "$normal_step"
  elif [ "$step_size" = "-normal" ]; then
    echo "-$normal_step"
  else
    echo "$step_size"
  fi
}

step=$(get_step $2)
half_step=$(($step / 2))

case $1 in
  left|right)
    yabai -m window --resize $1:$step:0
    ;;
  top|bottom)
    yabai -m window --resize $1:0:$step
    ;;
  top_left|top_right|bottom_left|bottom_right)
    yabai -m window --resize $1:$step:$step
    ;;
  corners)
    yabai -m window --resize top_left:$((-$half_step)):$((-$half_step))
    yabai -m window --resize bottom_right:$half_step:$half_step
    ;;
  *)
    yabai -m window --resize $1:$2:$3
    ;;
esac
