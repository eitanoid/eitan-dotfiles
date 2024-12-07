CONFIG=~/git/dotfiles/config

# alacritty

mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme $CONFIG/alacritty/themes


## zsh plugins

git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $CONFIG/zsh/plugins/zsh-autocomplete

git clone https://github.com/zsh-users/zsh-autosuggestions $CONFIG/zsh/plugins/zsh-autosuggestions


git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $CONFIG/zsh/plugins/fast-syntax-highlighting

git clone https://github.com/zsh-users/zsh-history-substring-search $CONFIG/zsh/plugins/zsh-history-substring-search


## ranger plugins

git clone https://github.com/alexanderjeurissen/ranger_devicons $CONFIG/ranger/plugins/ranger_devicons

#bidirectional text for hebrew
pip install python-bidi

#LS colors / system default colors theme
wget -O $CONFIG/ranger/colorschemes/ls_colors.py https://raw.githubusercontent.com/Nelyah/dotfiles/refs/heads/main/.config/ranger/colorschemes/ls_colors.py
