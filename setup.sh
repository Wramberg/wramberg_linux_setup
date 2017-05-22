#!/bin/sh

inst="sudo apt install -y"

# Install i3
$inst i3

# Install network applet
$inst nm-applet

# Autolock and lock
$inst xautolock
$inst i3lock

# Filemanagers
$inst ranger
$inst thunar

# Automount
$inst udiskie

# Image viewer
$inst sxiv

# Styling
$inst lxappearance

# Soundmanager
$inst volumeicon-alsa

# PDF reader
$inst evince 

# Set up i3 config link
ln -s $HOME/wramberg_linux_setup/i3_config $HOME/.config/i3/config

echo "Done - remember:"
echo "lxappearance"
echo "ranger bashrc hack"
echo "volume controls in tray"
