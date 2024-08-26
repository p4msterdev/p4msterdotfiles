#!/bin/bash

# Prompt the user to confirm installation
read -p "You are about to install Neil's config. Do you wish to proceed? (y/n): " choice
case "$choice" in 
  y|Y ) echo "Proceeding with installation...";;
  n|N ) echo "Installation aborted."; exit 1;;
  * ) echo "Invalid choice. Please run the script again and choose y or n."; exit 1;;
esac

# Update the system
sudo pacman -Syu

# Install Paru if not already installed
if ! command -v paru &> /dev/null
then
    echo "Paru not found. Installing Paru..."
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si
    cd ~
    rm -rf /tmp/paru
else
    echo "Paru is already installed."
fi

# Install necessary packages from official repositories
sudo pacman -S --needed hyprland kitty ranger git pipewire bluez bluez-utils btop networkmanager dart-sass wl-clipboard brightnessctl swww python gnome-bluetooth-3.0 hyprpaper hyprlock hyprcursor xdg-desktop-portal-hyprland zathura thunar nwg-look obs-studio noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-joypixels ttf-symbola ttf-dejavu ttf-font-awesome ttf-material-design-icons

# Install AUR packages using Paru
paru -S --needed grimblast-git gpu-screen-recorder hyprpicker matugen-bin python-gpustat aylurs-gtk-shell-git bun-bin papirus-icon-theme-git papirus-folders-catppuccin-git sddm-git ttf-ms-fonts ttf-google-fonts-git ttf-apple-emoji


# Enable Chaotic AUR
echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

# Add Chaotic AUR key and update package database
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -Sy chaotic-aur

# Install packages from Chaotic AUR
sudo pacman -S localsend obsidian librefox vesktop

# Instal My Dotfiles
git clone https://github.com/p4msterdev/p4msterdotfiles.git /tmp/p4msterdotfiles

# Copy the .config files to ~/.config/
cp -r /tmp/p4msterdotfiles/.config/* ~/.config/

# Copy the Wallpapers to ~/Pictures/Wallpapers/
mkdir -p ~/Pictures/Wallpapers
cp -r /tmp/p4msterdotfiles/Pictures/Wallpapers/* ~/Pictures/Wallpapers/

# install hyprpanel
mkdir -p ~/.config/ags
git clone https://github.com/Jas-SinghFSU/HyprPanel.git
ln -s $(pwd)/HyprPanel $HOME/.config/ags

# Install Hyprpanel fonts
cd Hyprpanel
./install_fonts.sh

# Install SDDM Astronaut Theme
git clone https://github.com/Keyitdev/sddm-astronaut-theme.git /tmp/sddm-astronaut-theme
sudo cp -r /tmp/sddm-astronaut-theme /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

# Configure SDDM to use the Astronaut theme
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf
# Clean up
# rm -rf /tmp/yourrepo /tmp/sddm-astronaut-theme

echo "Setup complete. Please reboot your system."

