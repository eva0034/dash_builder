#!/bin/bash

while true; do
    /home/pi/dash/bin/dash
    echo "Program exited. Restarting..."
    sleep 1  # Wait for a moment before restarting
done
