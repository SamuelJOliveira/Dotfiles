#!/bin/bash
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/aula-mirror.pid"

# Toggle: se já ativo, desativa
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    exec ~/.config/sway/scripts/aula-off.sh
fi

# Verifica se HDMI está ativo
if ! swaymsg -t get_outputs | python3 -c \
    "import json,sys; exit(0 if any(o['name']=='HDMI-A-1' and o['active'] for o in json.load(sys.stdin)) else 1)"; then
    notify-send -u critical -t 5000 "Modo Aula" "HDMI não detectado. Conecte o projetor."
    exit 1
fi

# Espelha HDMI-A-1 no notebook — sem mover workspaces
wl-mirror --scaling fit --fullscreen-output eDP-1 HDMI-A-1 &
echo $! > "$PIDFILE"

notify-send -t 2000 "Modo Aula" "Ativado — notebook clonando o monitor externo"
