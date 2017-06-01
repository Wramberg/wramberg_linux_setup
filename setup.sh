#!/bin/sh

inst="sudo apt install -y"
pip="sudo pip install"
sudo apt update

# Install i3
$inst i3

# Install network applet
#$inst nm-applet

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

# Install tmux
$inst tmux

# Install rofi
$inst rofi

# Remove nautilus
sudo apt remove -y nautilus

# Remove dunst
# sudo apt remove -y dunst

# Set up i3 config link
mkdir -p $HOME/.config/i3/
ln -s $HOME/wramberg_linux_setup/i3_config $HOME/.config/i3/config

# When quitting ranger cd into dir it was standing in
cmd="alias ranger='ranger --choosedir=/tmp/.rangerdir;cd \$(cat /tmp/.rangerdir)'"
title="#ranger-tweak"

grep "$title" $HOME/.bashrc > /dev/null
result=$?
if [ $result -eq 1 ]; then
    echo "" >> $HOME/.bashrc
    echo $title >> $HOME/.bashrc
    echo $cmd >> $HOME/.bashrc
fi

# Set editor to sublime text in bashrc
editor="export EDITOR='subl -b'"
title="#default-editor"

grep "$title" $HOME/.bashrc > /dev/null
result=$?
if [ $result -eq 1 ]; then
    echo "" >> $HOME/.bashrc
    echo $title >> $HOME/.bashrc
    echo $editor >> $HOME/.bashrc
fi

# Customize notify a bit - https://askubuntu.com/questions/128474/how-to-customize-on-screen-notifications
sudo add-apt-repository ppa:leolik/leolik
sudo apt-get update
#sudo apt-get upgrade
sudo apt-get install libnotify-bin
pkill notify-osd
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install notifyosdconfig


echo "Done - remember:"
# echo "ranger bashrc hack"
echo "lxappearance - widget clearlook"
echo "lxappearance - icons"
echo "volume controls keybindings in tray"
echo "volume controls icon"
echo "terminal - colors"
echo "terminal - hide menu on startup"
