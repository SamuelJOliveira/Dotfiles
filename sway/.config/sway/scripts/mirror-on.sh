#!/bin/bash
swaymsg output eDP-1 mode 1366x768 position 0 0
swaymsg output HDMI-A-1 mode 1920x1080@100Hz position 0 0
notify-send -t 2000 "Display" "Espelhamento ativado"
