#! /sbin/bash
if [pidof waybar = 0 ]; then
    waybar
else
    killall waybar
    waybar
fi
