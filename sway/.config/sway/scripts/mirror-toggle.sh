#!/bin/bash
SCRIPTS="$HOME/.config/sway/scripts"
X=$(swaymsg -t get_outputs | python3 -c \
    "import json,sys; [print(o['rect']['x']) for o in json.load(sys.stdin) if o['name']=='HDMI-A-1']")
if [ "$X" = "0" ]; then
    "$SCRIPTS/mirror-off.sh"
else
    "$SCRIPTS/mirror-on.sh"
fi
