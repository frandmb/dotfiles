#!/usr/bin/env bash

swww-daemon &
swww img ~/Pictures/oled.jpg &
nm-applet --indicator &
waybar &
