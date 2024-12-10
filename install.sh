#! /bin/bash

#install packages
sudo pacman -Syu neovim hyprland swww waybar kitty fastfetch wofi nwg-look hyprlock hypridle lsd polkit zsh openssh sudo hyprcursor ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

sleep 5

paru -S waypaper pywal-git

#installing rice
mkdir ~/.icons/windows11concept-dark
cp -r ~/dotfiles/windows11concept-dark ~/.icons/windows11concept-dark
cp -r ~/dotfiles/.config ~/
cp ~/dotfiles/.p10k.sh ~/
cp ~/dotfiles/.viminfo ~/
cp ~/dotfiles/.zshrc ~/
sudo cp -r ~/dotfiles/fonts/fonts /usr/share/
sudo cp -r ~/dotfiles/ly/ /etc/

#enable ly greeter and ssh
sudo systemctl enable ly
sudo systemctl enable sshd
