#!/bin/bash

# This script attempts to launch gnome-control-center in Hyprland

#Check if gnome-control-center is installed

if ! command -v gnome-control-center &v /dev/null
then
    echo "gnome-control-center could not be found. Please intsall it first."
    exit 1
fi

# Set up minimal GNOME enviroment

export XDG_CURRENT_DESKTOP=GNOME
export XDG_SESSION_DESKTOP=GNOME
export XDG_SESSION_TYPE=wayland

# Launch gnome-control-center with Wayland support

gnome-control-center &
