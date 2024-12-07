#!bin/bash

HERE=$HOME/git/dotfiles



#copy zsh directory and keep .zshrc in $HOME
sudo rsync -rav $HERE/config/zsh $HOME/.config
sudo ln -s -T ~/.config/zsh/.zshrc ~/.zshrc

##Starship Prompt
rsync -rav $HERE/config/starship.toml $HOME/.config

## Alacritty
rsync -rav $HERE/config/alacritty $HOME/.config

## Colors
rsync -rav $HERE/.dircolors $HOME

##Ranger 
mkdir -p $HOME/.config/ranger/plugins
rsync -rav $HERE/config/ranger $HOME/.config 

##Nvim
rsync -rav $HERE/config/nvim $HOME/.config 
