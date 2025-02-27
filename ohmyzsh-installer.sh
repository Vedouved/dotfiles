#install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

#install zsh themes and addons
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#install rc files
cp ~/dotfiles/.p10k.sh ~/
cp ~/dotfiles/.zshrc ~/
