#!/bin/sh
export REMOTEHOST=127.0.0.1
# Allow remote X display
export DISPLAY=${REMOTEHOST}:0.0
# Allow remote audio
export PULSE_SERVER=tcp:${REMOTEHOST}:4713
