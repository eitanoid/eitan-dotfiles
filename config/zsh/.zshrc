#Exports 
export ZSH=$HOME/.config/zsh/.zshrc
#Path
export PATH="$HOME/.local/bin":$PATH
export PATH=$PATH:/usr/local/go/bin # go paths
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin # rust

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim -c Man! -o -'

#This config file
ZSHF=$HOME/.config/zsh

# enable vi mode in shell
bindkey -v

# Ranger preview syntax highlighting style
export HIGHLIGHT_STYLE=rootwater

# Path to of Screen Saver
SCREEN_SAVER=$HOME/git/pipes-sh/pipes.sh

# History
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


# Load plugins
source $ZSHF/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSHF/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHF/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSHF/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHF/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# zsh history-substring-search
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down

# completion menu 
bindkey              '^I' menu-select # Tab
bindkey -M menuselect "^I" .accept-line #Tab
bindkey -M menuselect "l" menu-complete
bindkey -M menuselect "h" reverse-menu-complete
bindkey -M menuselect "j" down-history 
bindkey -M menuselect "k" up-history 
#enter to pick file but not continue down hierarchy

#Autosuggest color - need this to work in tmux
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8" ##,bg=cyan,bold,underline"

# zsh vi settings
ZVM_VI_SURROUND_BINDKEY="s-prefix"

# edit prompt in editor binding

# open editor in current working directory and set filetype to bash
ZVM_VI_EDITOR='nvim -c "lcd ." -c "set filetype=bash"'
zvm_after_init_commands+=('zvm_bindkey visual "vv" zvm_vi_edit_command_line')
zvm_after_init_commands+=('zvm_bindkey visual -r "v"') # press v 3 times to open editor

function zle-line-init() { # insert mode automatically on new line
  zle zvm_enter_insert_mode       
}
zle -N zle-line-init

#Vi mode related settings
# Change cursor shape for different vi modes. source: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
#
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


######################################################################################################

#C dev stuff

function clangrun() { # like `go run` but for c.
	clang "${1}" -o "${1}".out "${@:2}" &&  echo "compiled successfully" && ./"${1}.out"
}

######################################################################################################

#Inactivty Screen Saver
TMOUT=1000 #~20 mins
trap "echo ;bash $SCREEN_SAVER" ALRM

######################################################################################################

#alias
alias cd='z'

# use colors set by .dircolors
eval "$(dircolors ~/.dircolors)"
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#set pointer
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
