#!/bin/sh

inst="sudo apt install -y"
pip="sudo pip install"

sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt update

# Random deps
$inst gcc clang make

# Install i3 gaps deps and i3 gaps itself
$inst libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev \
	libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev \
	meson

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
mkdir -p build && cd build
sudo meson ..
sudo ninja
sudo meson install

# Autolock and lock
$inst xautolock
$inst i3lock

# Filemanagers
$inst ranger
$inst thunar

# Automount
#$inst udiskie

# Image viewer
$inst sxiv

# Styling
$inst lxappearance

# Soundmanager
#$inst volumeicon-alsa

# PDF reader
$inst evince

# Install polybar
$inst compton
$inst polybar

# pip
$inst python3-pip
$pip --upgrade pip3

# Wallpaper
$inst feh
feh --bg-fill $HOME/wramberg_linux_setup/wallpapers/1449203821767.jpg

# Install mate terminal
$inst mate-terminal

# Install arandr
$inst arandr

# Install tmux
$inst tmux

# Install rofi
$inst rofi

# Remove nautilus - install thunar as backup filemanager
$inst thunar

# For sound control
#$inst pavucontrol

# Remove dunst
# sudo apt remove -y dunst

# Set up i3 config link
mkdir -p $HOME/.config/i3/
ln -s $HOME/wramberg_linux_setup/i3_config $HOME/.config/i3/config

# Setup polybar config link
mkdir -p $HOME/.config/polybar/
ln -s $HOME/wramberg_linux_setup/polybar_config $HOME/.config/polybar/config

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
#editor="export EDITOR='subl -b'"
#title="#default-editor"

#grep "$title" $HOME/.bashrc > /dev/null
#result=$?
#if [ $result -eq 1 ]; then
#    echo "" >> $HOME/.bashrc
#    echo $title >> $HOME/.bashrc
#    echo $editor >> $HOME/.bashrc
#fi

# Customize notify a bit - https://askubuntu.com/questions/128474/how-to-customize-on-screen-notifications
# sudo add-apt-repository ppa:leolik/leolik
# sudo apt-get update
#sudo apt-get upgrade
# sudo apt-get install libnotify-bin
# pkill notify-osd
# sudo add-apt-repository ppa:nilarimogard/webupd8
# sudo apt-get update
# sudo apt-get install notifyosdconfig

# Install fonts
$inst fonts-material-design-icons-iconfont
$inst fonts-font-awesome

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip
unzip 3270.zip -d ~/.fonts
fc-cache -fv

# Add usb dev script to polybar
mkdir $HOME/polybar-scripts/
ln -s $HOME/wramberg_linux_setup/rofi-usb-mount.sh $HOME/polybar-scripts/rofi-usb-mount.sh

# Add rofi theme
mkdir -p $HOME/.config/rofi/
ln -f -s $HOME/wramberg_linux_setup/rofi.rasi $HOME/.config/rofi.rasi
ln -f -s $HOME/wramberg_linux_setup/rofi_config $HOME/.config/rofi/config

# Fix nm applet icon
mkdir -p $HOME/.icons/Humanity/devices/16/
mkdir -p $HOME/.icons/Humanity/status/16/
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-device-wired.svg $HOME/.icons/Humanity/devices/16/nm-device-wired.svg
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-no-connection.svg $HOME/.icons/Humanity/status/16/nm-no-connection.svg
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-signal-00.svg $HOME/.icons/Humanity/status/16/nm-signal-00.svg
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-signal-25.svg $HOME/.icons/Humanity/status/16/nm-signal-25.svg
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-signal-50.svg $HOME/.icons/Humanity/status/16/nm-signal-50.svg
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-signal-75.svg $HOME/.icons/Humanity/status/16/nm-signal-75.svg
ln -f -s /usr/share/icons/ubuntu-mono-dark/status/24/nm-signal-100.svg $HOME/.icons/Humanity/status/16/nm-signal-100.svg

# Laptop backlight control
cd /tmp/ && \
	git clone https://github.com/haikarainen/light.git && \
	cd light/ && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install
ln -s $HOME/wramberg_linux_setup/polybar_backlight_ctrl.py $HOME/polybar-scripts/polybar_backlight_ctrl.py

# Battery status
ln -s $HOME/wramberg_linux_setup/polybar_power_status.py $HOME/polybar-scripts/polybar_power_status.py

echo "Done - remember:"
echo "lxappearance - widget clearlook"
echo "lxappearance - icons"
echo "volume controls keybindings in tray"
echo "volume controls icon"
echo "terminal - colors and transparancy"
echo "terminal - hide menu on startup"
echo "terminal - copy on selection"
