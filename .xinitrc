#!/bin/sh

# Audio setup
if command -v pactl >/dev/null 2>/dev/null
then
	if pactl list cards short | grep Jabra >/dev/null
	then
		pactl set-card-profile alsa_card.usb-GN_Netcom_A_S_Jabra_EVOLVE_LINK_MS_0001C028C21208-00 input:analog-mono
		pactl set-source-mute alsa_input.usb-GN_Netcom_A_S_Jabra_EVOLVE_LINK_MS_0001C028C21208-00.analog-mono true
	fi

	pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
fi

# Set up daemons that only run on some machines
command -v ckb-next >/dev/null 2>/dev/null && ckb-next -b &
command -v amixer   >/dev/null 2>/dev/null && amixer -q -- set Master -0dB

# Set up the two universal daemons -- ssh-agent and the status tray
eval $(ssh-agent)
dwmstatus &

# Run the window manager
/usr/local/bin/dwm

# Ensure that ssh-agent goes away
ssh-agent -k
