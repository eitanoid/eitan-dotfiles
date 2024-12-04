#Exports
export PATH="$HOME/.local/bin":$PATH
#Export Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
#Export ueberzugpp for image preview in ranger
export PATH=$PATH:$HOME/ueberzugpp/build 

export ZSH=$HOME/.config/zsh/.zshrc

ZSHF=$HOME/.config/zsh 

HISTFILE=${HOME}/.zsh_history

export HISTSIZE=20000
export SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

export LANG=en_US.UTF-8
#Theme



autoload -Uz compinit
compinit

#Plugins
source $ZSHF/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSHF/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHF/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZSHF/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh


#editor
export EDITOR=nvim
export VISUAL=nvim

#Plugins

#cursor set again in alacritty
#echo -ne "\e[6 q"


eval "$(starship init zsh)"



