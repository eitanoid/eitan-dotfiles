
#copy zsh directory and keep .zshrc in $HOME
mkdir -p  $HOME/.config/zsh
rsync -rav $(pwd)/config/zsh $HOME/.config
ln -s -T ~/.config/zsh/.zshrc ~/.zshrc

echo "Synced Zsh"

##Starship Prompt
rsync -rav $(pwd)/config/starship.toml $HOME/.config
echo "Synced Starship"

## Alacritty
mkdir -p $HOME/.config/alacritty
rsync -rav $(pwd)/config/alacritty $HOME/.config
echo "Synced Alacritty"

## Foot
mkdir -p $HOME/.config/foot
rsync -rav $(pwd)/config/foot $HOME/.config
echo "Synced Foot"

## Kitty
mkdir -p $HOME/.config/kitty
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
mkdir -p $HOME/.config/nvim
rsync -rav $(pwd)/config/nvim $HOME/.config
echo "Synced Neovim"

# tmux
mkdir -p $HOME/.config/tmux
rsync -rav $(pwd)/config/tmux $HOME/.config
echo "Synced Tmux"

##Nvim - latex formatter
# rsync -rav $(pwd)/config/tex-fmt $HOME/.config
# echo "Synced tex-fmt"

##Zathura
mkdir -p $HOME/.config/zathura
rsync -rav $(pwd)/config/zathura $HOME/.config 
echo "Synced Zathura"

##Stylua
rsync -rav $(pwd)/.stylua.toml $HOME/
echo "Synced Stylua"

##LatexIndent
rsync -rav $(pwd)/indentconfig.yaml $HOME/
echo "Synced LatexIndent"
