#! /sbin/bash
pidof waybar || killall -SIGUSR2 waybar
