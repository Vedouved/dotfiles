#! /bin/bash

#install packages

sudo pacman -Syu neovim hyprland swww waybar zsh kitty fastfetch wofi nwg-look hyprlock hyprpidle lsd

paru -S waypaper pywal-git

#change shellto zsh
chsh -s $(which zsh)

#install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

#install zsh themes and addons
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#installing rice
cp -r ~/dotfiles/.config ~/
cp ~/dotfiles/.p10k.sh ~/
cp ~/dotfiles/.viminfo ~/
cp ~/dotfiles/.zshrc ~/
sudo cp -r ~/dotfiles/fonts/fonts /usr/share/fonts


