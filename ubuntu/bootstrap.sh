#!/bin/bash
gosu $APP_USER mkdir -p "$HOME_DIR/.vnc"
gosu $APP_USER x11vnc -storepasswd "2hard4u" "$HOME_DIR/.vnc/passwd"
Xvfb $DISPLAY -screen 0 1280x720x24 &
gosu $APP_USER sleep 5
gosu $APP_USER startfluxbox &
gosu $APP_USER sleep 5
gosu $APP_USER x11vnc -display $DISPLAY -rfbport 5901 -usepw -forever -q &
# gosu $APP_USER sleep 5
# gosu $APP_USER /docker/noVNC/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
wait $!
