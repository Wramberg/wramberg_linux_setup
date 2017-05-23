#!/bin/sh

inst="sudo apt install -y"
pip="sudo pip install"
sudo apt update

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

# pip
$inst python-pip
$pip --upgrade pip

# py3status
$pip py3status

# Deps for py3status clock module
$pip pytz
$pip tzlocal

# Deps for custom py3status modules
$pip psutil

# Wallpaper
$inst feh
feh --bg-scale b6xnLhT.jpg

# Install rxvt terminal
#sudo software-properties-gtk -e universe
#sudo apt update
#$inst rxvt

# Install mate terminal
$inst mate-terminal

# Install arandr
$inst arandr

# Remove nautilus
sudo apt remove -y nautilus

# Remove dunst
# sudo apt remove -y dunst

# Set up i3 config link
mkdir -p $HOME/.config/i3/
ln -s $HOME/wramberg_linux_setup/i3_config $HOME/.config/i3/config

echo "Done - remember:"
echo "lxappearance"
echo "ranger bashrc hack"
echo "volume controls keybindings in tray"
echo "terminal colors"
echo "terminal menu"
