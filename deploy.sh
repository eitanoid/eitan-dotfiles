HERE=$HOME/git/dotfiles

#cp .zshrc $HOME
#cp .config/nvim $HOME/.config/nvim
#cp .config/alacritty $HOME/.config/alacritty
#cp .config/ranger $HOME/.config/ranger

#copy zsh directory and keep .zshrc in $HOME
sudo cp $HERE/.config/zsh $HOME/.config -r && ln -s -T ~/.config/zsh/.zshrc ~/.zshrc

cp $HERE/.config/starship.toml $HOME/.config

cp $HERE/.config/alacritty $HOME/.config -r

cp $HERE/.config/ranger $HOME/.config -r

cp $HERE/.config/nvim $HOME/.config -r
