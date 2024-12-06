
HERE=~/git/dotfiles/config

#zsh plugins
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $HERE/zsh/plugins/zsh-autocomplete

git clone https://github.com/zsh-users/zsh-autosuggestions $HERE/zsh/plugins/zsh-autosuggestions

git clone https://github.com/jeffreytse/zsh-vi-mode.git $HERE/zsh/plugins/zsh-vi-mode

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $HERE/zsh/plugins/fast-syntax-highlighting

git clone https://github.com/zsh-users/zsh-history-substring-search $HERE/zsh/plugins/zsh-history-substring-search

# bat syntaxes

wget -O $HERE/bat/syntaxes/rainbow_csv.sublime-syntax https://raw.githubusercontent.com/mechatroner/sublime_rainbow_csv/master/rainbow_csv.sublime-syntax


# ranger plugins

git clone https://github.com/alexanderjeurissen/ranger_devicons $HERE/ranger/plugins/ranger_devicons

#bidirectional text for hebrew
pip install python-bidi

#dracula theme

curl -O https://raw.githubusercontent.com/dracula/ranger/master/dracula.py $HERE/ranger/colorschemes

