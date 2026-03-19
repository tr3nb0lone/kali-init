#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# wait till the processes have been shut:
while pgrep -u  $UID -x polybar >/dev/null; do sleep 1;done

# launch the bar:
polybar mainbar &
