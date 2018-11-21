#!/bin/bash
mkdir -p "$HOME_DIR/.vnc"
x11vnc -storepasswd "2hard4u" "$HOME_DIR/.vnc/passwd"
Xvfb $DISPLAY -screen 0 1280x720x24 &
sleep 5
startfluxbox &
sleep 5
x11vnc -display $DISPLAY -rfbport 5901 -usepw -forever -q &
# sleep 5
# /docker/noVNC/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
wait $!
