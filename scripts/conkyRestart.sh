#!/bin/bash
notify-send "Initiating Conky"
# Check to see if Conky is running. If it is, kill it.
CONKY_PID="$(pidof conky)"
if [ "$CONKY_PID" > "0" ]; then
    kill $CONKY_PID
    sleep 5
fi
# Start Conky
conky 2>/dev/null &