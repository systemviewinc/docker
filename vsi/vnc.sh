#!/bin/bash

SCREEN_SIZE=${SCREEN_SIZE:=1280x800}

# Remove VNC lock (if process already killed)
rm /tmp/.X1-lock /tmp/.X11-unix/X1
# Run VNC server with tail in the foreground
vncserver :1 -geometry ${SCREEN_SIZE} -depth 24 && tail -F ~/.vnc/*.log
