
#copy zsh directory and keep .zshrc in $HOME
rsync -rav $(pwd)/config/zsh $HOME/.config
ln -s -T ~/.config/zsh/.zshrc ~/.zshrc

echo "Synced Zsh"

##Starship Prompt
rsync -rav $(pwd)/config/starship.toml $HOME/.config
echo "Synced Starship"

## Alacritty
rsync -rav $(pwd)/config/alacritty $HOME/.config
echo "Synced Alacritty"

## Foot
rsync -rav $(pwd)/config/foot $HOME/.config
echo "Synced Foot"

## Kitty
rsync -rav $(pwd)/config/kitty $HOME/.config
echo "Synced Kitty"


## Colors
rsync -rav $(pwd)/.dircolors $HOME
echo "Synced Dircolors"

##Ranger 
mkdir -p $HOME/.config/ranger/plugins
rsync -rav $(pwd)/config/ranger $HOME/.config
echo "Synced Ranger"

##Nvim
rsync -rav $(pwd)/config/nvim $HOME/.config
echo "Synced NeoVim"

##Nvim - latex formatter
rsync -rav $(pwd)/config/tex-fmt $HOME/.config
echo "Synced tex-fmt"

##Zathura
rsync -rav $(pwd)/config/zathura $HOME/.config 
echo "Synced Zathura"
