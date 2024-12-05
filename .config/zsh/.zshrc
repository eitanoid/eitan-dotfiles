#Exports
export PATH="$HOME/.local/bin":$PATH
#Export Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
#Export ueberzugpp for image preview in ranger
export PATH=$PATH:$HOME/ueberzugpp/build 

#ZSH variables
export ZSH=$HOME/.config/zsh/.zshrc
ZSHF=$HOME/.config/zsh

#editor
export EDITOR=nvim
export VISUAL=nvim

#Location of Screen Saver
SCEEN_SAVER=$HOME/git/pipes.sh

#History
HISTFILE=${HOME}/.zsh_history
export HISTSIZE=20000
export SAVEHIST=20000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
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
source $ZSHF/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

#source <(fzf --zsh)

#zsh history-substring-search
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
bindkey -M vicmd '<k>' history-substring-search-up
bindkey -M vicmd '<j>' history-substring-search-down

#alias
alias bat='batcat'
alias cat='bat'
alias cd='z'

#Inactivty Screen Saver
TMOUT=1000 #~20 mins
trap 'echo ;bash $SCEEN_SAVER/pipes.sh' ALRM
#cursor set again in alacritty
#echo -ne "\e[6 q"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"



