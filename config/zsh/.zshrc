#Exports
export PATH="$HOME/.local/bin":$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/git/ueberzugpp/build 
export PATH=$PATH:$HOME/git/yazi/target/release 

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

#.bashrc script for adding colors to ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(dircolors ~/.dircolors)"

