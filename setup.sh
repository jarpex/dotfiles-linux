#!/bin/sh
sudo pacman -S git artix-archlinux-support
sudo pacman-key --populate archlinux
sudo rm /etc/pacman.conf
sudp cp etc/pacman.conf /etc/pacman.conf
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
yay -Sy bspwm dunst dmenu sxhkd clpimg numlockx arandr thunar wmname redshift alacritty escrotum-git scrot chromium neovim neofetch playerctl ttf-font-awesome xorg-server xorg-apps xorg-xinit mesa
cp /etc/X11/xinit/xinitrc ~/.xinitrc
mkdir ~/.config/bspwm
cp .config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc
mkdir ~/.config/sxhkd
cp .config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp home/.xinitrc ~/.xinitrc