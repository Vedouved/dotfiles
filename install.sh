#! /bin/bash

#install packages
sudo pacman -Syu --needed base-devel neovim hyprland swww waybar kitty fastfetch wofi nwg-look thefuck hyprlock hypridle lsd polkit zsh openssh sudo hyprcursor otf-font-awesome ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono brightnessctl pipewire pavucontrol wireplumber pipe-pulse bluez bluez-utils fzf bat duf 7zip alsa-lib pipewire-alsa pipewire-jack yazi ffmpeg jq poppler fd rg zoxide ImageMagick wl-clipboard

#install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

sleep 5

paru -S waypaper
paru -S hyprshot
paru -S pywal-git

echo "Do you have an asus laptop? (Y/N)"
read ans
if [ $ans == "Y" ] | [ $ans == "y" ]; then
  paru -S asusctl
  paru -S supergfxctl
fi

#installing rice
mkdir ~/.icons
cp -r ~/dotfiles/windows11concept-dark ~/.icons/
cp ~/dotfiles/.viminfo ~/
cp -r ~/dotfiles/.config ~/
sudo cp -r ~/dotfiles/fonts/fonts /usr/share/
sudo cp -r ~/dotfiles/ly/ /etc/

#enable ly greeter and ssh
sudo systemctl enable ly
sudo systemctl enable sshd
systemctl --user enable pipewire wireplumber pipewire.socket pipewire-pulse
