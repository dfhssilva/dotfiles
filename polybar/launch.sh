#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar top -c ~/.config/polybar/config.ini &

# Launch polybar on external monitor if connected
external_monitor=HDMI2
if [[ $(xrandr -q | grep "$external_monitor connected") ]]; then
    polybar top_external -c ~/.config/polybar/config.ini &
fi
