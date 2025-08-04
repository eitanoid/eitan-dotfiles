#Exports 
export ZSH=$HOME/.config/zsh/.zshrc
#Path
PATH="$HOME/.local/bin":$PATH
PATH=$PATH:/usr/local/go/bin # go paths
PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin # rust

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim -c Man! -o -'

#This config file
ZSHF=$HOME/.config/zsh

# Ranger preview syntax highlighting style
export HIGHLIGHT_STYLE=rootwater

# Path to of Screen Saver
SCREEN_SAVER=$HOME/git/pipes-sh/pipes.sh

# History
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
HISTFILE=${HOME}/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# Load plugins
source $ZSHF/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSHF/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHF/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSHF/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHF/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# load completions
autoload -Uz compinit && compinit

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # caseinsensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


# enable async mode for autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)" # limit suggestions to 50 chars
# Keybinds
bindkey -v

export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# completion menu 
bindkey              '^I' menu-select # Tab
bindkey -M menuselect "^I" .accept-line #Tab
bindkey -M menuselect "l" menu-complete
bindkey -M menuselect "h" reverse-menu-complete
bindkey -M menuselect "j" down-history 
bindkey -M menuselect "k" up-history 


# zsh vi

# changes engine to fix "zvm_readkeys_handler" undefined-key on startup
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
ZVM_VI_SURROUND_BINDKEY="s-prefix"

# edit prompt in neovim; open editor in current working directory and set filetype to bash
ZVM_VI_EDITOR='nvim -c "lcd ." -c "set filetype=bash"'
zvm_after_init_commands+=('zvm_bindkey visual "vv" zvm_vi_edit_command_line')
zvm_after_init_commands+=('zvm_bindkey visual -r "v"') # press v 3 times to open editor

ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT # start in insert mode on new line

# Change cursor shape for different vi modes. source: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
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


# C jank
function clangrun() { # like `go run` but for c.
	clang "${1}" -o "${1}".out "${@:2}" &&  echo "compiled successfully" && ./"${1}.out"
}

#Inactivty Screen Saver
TMOUT=5000 #~100 mins
trap "echo ;bash $SCREEN_SAVER" ALRM

## completions
export FPATH="$HOME/.config/zsh/completions/:$FPATH"

alias calc='calcpy' # https://github.com/idanpa/calcpy
alias calculator='calcpy'
alias cd='z'


eval "$(dircolors $HOME/.dircolors)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
