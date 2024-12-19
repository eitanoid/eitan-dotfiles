#Exports
export PATH="$HOME/.local/bin":$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux # TeXLive Install

#ZSH variables
export ZSH=$HOME/.config/zsh/.zshrc
ZSHF=$HOME/.config/zsh

#editor
export EDITOR=nvim
export VISUAL=nvim

#Ranger preview syntax highlighting style
export HIGHLIGHT_STYLE=rootwater

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

autoload -Uz compinit
compinit


#Plugins
source $ZSHF/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSHF/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHF/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSHF/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

#source <(fzf --zsh)

# enable vi mode
bindkey -v

#zsh history-substring-search
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down
bindkey '^N' history-substring-search-up
bindkey '^P' history-substring-search-down

# autocomplete 
bindkey              '^I' menu-select # Tab
bindkey "$terminfo[kcbt]" menu-select #Shift + Tab
bindkey -M menuselect "l" menu-complete
bindkey -M menuselect "h" reverse-menu-complete
bindkey -M menuselect "j" down-history 
bindkey -M menuselect "k" up-history 
bindkey -M menuselect "^I" .accept-line #Tab
#enter to pick file but not continue down hierarchy

#Autosuggest color - need this to work in tmux
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8" ##,bg=cyan,bold,underline"

######### Change cursor shape for different vi modes. source : https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#############


#alias
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
