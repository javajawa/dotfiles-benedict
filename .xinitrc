#!/bin/sh

if [ -e "$HOME/.xinitrc.local" ]
then
	source "$HOME/.xinitrc.local"
fi

# Set up daemons that only run on some machines
command -v ckb-next >/dev/null 2>/dev/null && ckb-next -b &
command -v amixer   >/dev/null 2>/dev/null && amixer -q -- set Master -0dB

# Set up the two universal daemons -- ssh-agent and the status tray
eval $(ssh-agent)
dwmstatus &

# Run the window manager
dwm

# Ensure that ssh-agent goes away
ssh-agent -k
