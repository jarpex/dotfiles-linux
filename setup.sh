#!/bin/sh
sudo  ln -sf /usr/share/zoneinfo/GMT-0  /etc/localtime
sudo pacman --noconfirm --needed -Syyu artix-archlinux-support git
sudo pacman-key --populate archlinux
sudo rm /etc/pacman.conf
sudo rm /etc/makepkg.conf
sudo rm /etc/sudoers.conf
sudo rm /etc/locale.conf
sudo rm /etc/modprobe.d/nobeep.conf
sudo cp etc/pacman.conf /etc/pacman.conf
sudo cp etc/makepkg.conf /etc/makepkg.conf
sudo cp etc/sudoers /etc/sudoers
sudo cp etc/locale.conf /etc/locale.conf
sudo cp etc/modprobe.d/nobeep.conf /etc/modprobe.d/nobeep.conf
sudo sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg --syncdeps --install --needed --noconfirm
cd ..
yay --noconfirm --needed -Sy alacritty arandr bspwm chromium xclip dash dialog dmenu dosfstools dunst exa-git exfat-utils fzf gsimplecal man-db mediainfo mpv noto-fonts-cjk neovim nerd-fonts-inconsolata numlockx python pipewire pipewire-pulse playerctl polybar poppler qimgv scrot simple-mtpfs sshfs sxhkd thunar ttf-font-awesome ttf-jetbrains-mono unrar unzip wmname xorg-apps xorg-server xorg-xdm xorg-xinit xorg-xinput zathura zathura-pdf-mupdf zip zsh zsh-fast-syntax-highlighting-git gnome-keyring libsecret qalculate-gtk
python -m ensurepip
~/.local/bin/pip3 install more-itertools
yay -S escrotum
git clone https://github.com/jarpex/ttf-ios-emoji
cd ttf-ios-emoji
makepkg --syncdeps --install --needed --noconfirm
cd ..
mkdir ~/Images/
mkdir ~/Images/Screenshots
cp /etc/X11/xinit/xinitrc ~/.xinitrc
mkdir ~/.config/bspwm
cp .config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc
mkdir ~/.config/sxhkd
cp .config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
mkdir ~/.config/polybar
cp .config/polybar/config ~/.config/polybar/config
cp .config/polybar/launch.sh ~/.config/polybar/launch.sh
cp .config/polybar/player-mpris-simple.sh ~/.config/polybar/player-mpris-simple.sh
cp .config/polybar/updates-pacman.sh ~/.config/polybar/updates-pacman.sh
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/player-mpris-simple.sh
chmod +x ~/.config/polybar/updates-pacman.sh
cp .config/chromium-flags.conf ~/.config/chromium-flags.conf
cp -R .config/chromium ~/.config/chromium
sudo cp -R usr/share/themes/Dracula /usr/share/themes/Dracula
mkdir ~/.config/alacritty
cp .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp home/.xinitrc ~/.xinitrc
cp home/.gtkrc-2.0 ~/.gtkrc-2.0e
sudo mkdir /mnt/Remote

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
            echo "You chose AMD"
            yay --noconfirm --needed -S mesa xf86-video-amdgpu
            ;;
        2)
            echo "You chose NVIDIA"
            yay --noconfirm --needed -S nvidia nvidia-utils
            ;;
        3)
            echo "You chose INTEL"
            yay --noconfirm --needed -S mesa xf86-video-intel
            ;;
        4)
            echo "You chose VMWARE"
            yay --noconfirm --needed -S mesa open-vm-tools xf86-video-vmware
            BACKTITLE="Screen Resolution"
            TITLE="Select screen resolution"
            MENU="Choose one of the following options:"

            OPTIONS=(1 "1280x720"
                    2 "1366x768"
                    3 "1600x900"
                    4 "1920x1080"
                    5 "2560x1440"
                    6 "3840x2160")

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
                        echo "xrandr --output Virtual1 --mode 1280x720" >> ~/.config/bspwm/bspwmrc
                        ;;
                    2)
                        echo "xrandr --output Virtual1 --mode 1366x768" >> ~/.config/bspwm/bspwmrc
                        ;;
                    3)
                        echo "xrandr --output Virtual1 --mode 1600x900" >> ~/.config/bspwm/bspwmrc
                        ;;
                    4)
                        echo "xrandr --output Virtual1 --mode 1920x1080" >> ~/.config/bspwm/bspwmrc
                        ;;
                    5)
                        echo "xrandr --output Virtual1 --mode 2560x1440" >> ~/.config/bspwm/bspwmrc
                        ;;
                    6)
                        echo "xrandr --output Virtual1 --mode 3840x2160" >> ~/.config/bspwm/bspwmrc
                        ;;
            esac
            ;;
        5)
            echo "You should install driver manually"
            ;;
esac
#Full install
BACKTITLE="Installation Type"
TITLE="Select installation type"
MENU="Choose one of the following options:"

OPTIONS=(1 "Minimal"
         2 "Full")

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
            echo "Skipping full installation"
            ;;
        2)
            echo "You chose Full"
            yay --noconfirm --needed -S redshift neofetch code-features simplenote-electron-bin diary-bin yt-dlp
            echo "redshift -l 55.7558:37.6173 -t 6500:2500 & #Sets yellowish screen" >> ~/.config/bspwm/bspwmrc
            ;;
esac
#DPMS
BACKTITLE="DPMS"
TITLE="Do you wanna disable DPMS?"
MENU="Choose one of the following options:"

OPTIONS=(1 "Skip"
         2 "Disable")

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
            echo "Skipping disabling DPMS"
            ;;
        2)
            echo "xset s off && xset dpms 0 0 0 #Disable DPMS" >> ~/.config/bspwm/bspwmrc
            echo "Disabled"
            ;;
esac

echo "Use startx to start X11"