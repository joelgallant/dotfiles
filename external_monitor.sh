#!/bin/bash

IN="eDP1"
EXT="HDMI1"

if [[ $1 == "off" ]]; then
    xrandr --output $EXT --off --output $IN --auto
elif [[ $1 == "on" ]]; then
    xrandr --output $IN --auto
    xrandr --output $EXT --auto --left-of $IN
elif ( xrandr | grep "$EXT disconnected" ); then
    xrandr --output $EXT --off --output $IN --auto
else
    xrandr --output $IN --auto
    xrandr --output $EXT --auto --left-of $IN
fi
