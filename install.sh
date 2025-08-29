CONFIG=$(pwd)/config

# alacritty
read -p "Download Alacritty Themes? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
	mkdir -p ~/.config/alacritty/themes &&
	git clone https://github.com/alacritty/alacritty-theme $CONFIG/alacritty/themes;
else
	echo "skipping";
fi

read -p "Download Zsh Plugins? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $CONFIG/zsh/plugins/zsh-autocomplete;
	git clone https://github.com/zsh-users/zsh-autosuggestions $CONFIG/zsh/plugins/zsh-autosuggestions;
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $CONFIG/zsh/plugins/fast-syntax-highlighting;
	git clone https://github.com/zsh-users/zsh-history-substring-search $CONFIG/zsh/plugins/zsh-history-substring-search;
    git clone https://github.com/jeffreytse/zsh-vi-mode.git $CONFIG/zsh/plugins/zsh-vi-mode;
	curl -sS https://starship.rs/install.sh | sh;
else
	echo "skipping";
fi

read -p "Download Ranger Plugins? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
	git clone https://github.com/alexanderjeurissen/ranger_devicons $CONFIG/ranger/plugins/ranger_devicons &&
	#LS colors / system default colors theme
	wget -O $CONFIG/ranger/colorschemes/ls_colors.py https://raw.githubusercontent.com/Nelyah/dotfiles/refs/heads/main/.config/ranger/colorschemes/ls_colors.py &&
	#bidirectional text for hebrew
	pip install python-bidi;
else
	echo "skipping";
fi

read -p "Download Tmux TPM? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    git clone https://github.com/tmux-plugins/tpm $CONFIG/tmux/plugins/tpm
else
	echo "skipping";
fi


