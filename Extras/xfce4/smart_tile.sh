#!/bin/bash

# Usage: ./smart_tile.sh [left|right|up|down]
DIRECTION=$1

# Validate direction
if [[ ! "$DIRECTION" =~ ^(left|right|up|down)$ ]]; then
  echo "Usage: $0 [left|right|up|down]"
  exit 1
fi

# Get window and screen info
WIN_ID=$(xdotool getactivewindow)
eval $(xdotool getwindowgeometry --shell "$WIN_ID")
WIN_X=$X
WIN_Y=$Y
WIN_W=$WIDTH
WIN_H=$HEIGHT

read SCREEN_WIDTH SCREEN_HEIGHT <<< $(xdpyinfo | awk '/dimensions:/ {print $2}' | awk -Fx '{print $1, $2}')
HALF_W=$((SCREEN_WIDTH / 2))
HALF_H=$((SCREEN_HEIGHT / 2))
MARGIN=20

# Functions for tiling
tile_left() {
  xdotool windowmove "$WIN_ID" 0 0 windowsize "$WIN_ID" $HALF_W $SCREEN_HEIGHT
}

tile_right() {
  xdotool windowmove "$WIN_ID" $HALF_W 0 windowsize "$WIN_ID" $HALF_W $SCREEN_HEIGHT
}

tile_up() {
  xdotool windowmove "$WIN_ID" 0 0 windowsize "$WIN_ID" $SCREEN_WIDTH $HALF_H
}

tile_down() {
  xdotool windowmove "$WIN_ID" 0 $HALF_H windowsize "$WIN_ID" $SCREEN_WIDTH $HALF_H
}

corner_tl() {
  xdotool windowmove "$WIN_ID" 0 0 windowsize "$WIN_ID" $HALF_W $HALF_H
}

corner_tr() {
  xdotool windowmove "$WIN_ID" $HALF_W 0 windowsize "$WIN_ID" $HALF_W $HALF_H
}

corner_bl() {
  xdotool windowmove "$WIN_ID" 0 $HALF_H windowsize "$WIN_ID" $HALF_W $HALF_H
}

corner_br() {
  xdotool windowmove "$WIN_ID" $HALF_W $HALF_H windowsize "$WIN_ID" $HALF_W $HALF_H
}

# Logic
case "$DIRECTION" in
  left)
    if (( WIN_X < MARGIN )); then
      # Already on left edge
      if (( WIN_Y < MARGIN )); then corner_bl; else corner_tl; fi
    else
      tile_left
    fi
    ;;
  right)
    if (( WIN_X > SCREEN_WIDTH - HALF_W - MARGIN )); then
      if (( WIN_Y < MARGIN )); then corner_br; else corner_tr; fi
    else
      tile_right
    fi
    ;;
  up)
    if (( WIN_Y < MARGIN )); then
      if (( WIN_X < MARGIN )); then corner_tr; else corner_tl; fi
    else
      tile_up
    fi
    ;;
  down)
    if (( WIN_Y > SCREEN_HEIGHT - HALF_H - MARGIN )); then
      if (( WIN_X < MARGIN )); then corner_br; else corner_bl; fi
    else
      tile_down
    fi
    ;;
esac
