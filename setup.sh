#!/bin/sh
sudo pacman -S git artix-archlinux-support
sudo pacman-key --populate archlinux
sudo rm /etc/pacman.conf
sudo cp etc/pacman.conf /etc/pacman.conf
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
yay -Sy bspwm dunst dialog dmenu sxhkd clpimg numlockx arandr thunar wmname redshift alacritty escrotum-git scrot chromium neovim neofetch playerctl ttf-font-awesome xorg-server xorg-apps xorg-xinit
cp /etc/X11/xinit/xinitrc ~/.xinitrc
mkdir ~/.config/bspwm
cp .config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc
mkdir ~/.config/sxhkd
cp .config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp home/.xinitrc ~/.xinitrc

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="GPU Driver Installer"
TITLE="Select your GPU"
MENU="Choose one of the following options:"

OPTIONS=(1 "AMD"
         2 "NVIDIA"
         3 "INTEL"
         4 "VMWARE"
         5 "Skip")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            yay -S xf86-video-amdgpu mesa
            ;;
        2)
            echo "You chose Option 2"
            yay -S nvidia nvidia-utils
            ;;
        3)
            echo "You chose intel"
            yay -S xf86-video-intel mesa
            ;;
        4)
            echo "You chose VMWARE"
            yay -S xf86-video-vmware mesa
            ;;
        5)
            echo "You should install driver manually"
            ;;
esac