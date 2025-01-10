#! /bin/bash

#install packages
sudo pacman -Syu --needed base-devel neovim hyprland swww waybar kitty fastfetch wofi nwg-look hyprlock hypridle lsd polkit zsh openssh sudo hyprcursor ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono brightnessctl

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
cp -r ~/dotfiles/.config ~/
cp ~/dotfiles/.p10k.sh ~/
cp ~/dotfiles/.viminfo ~/
cp ~/dotfiles/.zshrc ~/
sudo cp -r ~/dotfiles/fonts/fonts /usr/share/
sudo cp -r ~/dotfiles/ly/ /etc/

#enable ly greeter and ssh
sudo systemctl enable ly
sudo systemctl enable sshd
