#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi


username=$(id -u -n 1000)
builddir=$(pwd)


# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
#mkdir -p /usr/share/sddm/themes
cp .Xresources /home/$username
cp .Xnord /home/$username
cp .zshrc /home/$username
cp .zshrc.bak /home/$username
cp -R dotconfig/* /home/$username/.config/
cp bg.jpg /home/$username/Pictures/
mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username
#tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
#mv /home/$username/.config/sddm.conf /etc/sddm.conf

# Installing sugar-candy dependencies
pacman -S libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 -y
# Installing Essential Programs 
pacman -S bspwm sxhkd rofi polybar picom thunar nitrogen unzip wget pulseaudio pavucontrol polkit-gnome alacritty sddm linux linux-headers vim neofetch flameshot psmisc papirus-icon-theme mpv thunar-archive-plugin zsh pacman-contrib feh lxappearance papirus-icon-theme lxappearance sddm variety


# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip


