#!/bin/bash
# Startup script for Hyprland

# Kill existing instances
killall -q waybar
killall -q dunst
killall -swww swww

# Start swww (wallpaper daemon)
swww init &
swww img ~/.local/share/backgrounds/boykisser.png &

# Start Waybar
waybar &

# Start notification daemon
dunst &

# Start polkit agent
/usr/lib/polkit-kde/polkit-kde-authentication-agent-1 &

# Start clipboard manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

# Set cursor theme
hyprctl setcursor Catppuccin-Mocha-Lavender 24
