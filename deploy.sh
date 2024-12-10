HERE=$HOME/git/dotfiles

#copy zsh directory and keep .zshrc in $HOME
rsync -rav $HERE/config/zsh $HOME/.config
ln -s -T ~/.config/zsh/.zshrc ~/.zshrc

echo "Synced Zsh"

##Starship Prompt
rsync -rav $HERE/config/starship.toml $HOME/.config
echo "Synced Starship"

## Alacritty
rsync -rav $HERE/config/alacritty $HOME/.config
echo "Synced Alacritty"

## Colors
rsync -rav $HERE/.dircolors $HOME
echo "Synced Dircolors"

##Ranger 
mkdir -p $HOME/.config/ranger/plugins
rsync -rav $HERE/config/ranger $HOME/.config 
echo ""

##Nvim
rsync -rav $HERE/config/nvim $HOME/.config 
echo "Synced NeoVim"
