#!/bin/bash
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/aula-mirror.pid"

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
fi

notify-send -t 2000 "Modo Aula" "Desativado"
