ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#Path
PATH="$HOME/.local/bin":$PATH
PATH=$PATH:/usr/local/go/bin # go paths
PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin # rust

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim -c Man! -o -'

# Ranger preview syntax highlighting style
export HIGHLIGHT_STYLE=rootwater

# History
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
HISTFILE=${HOME}/.zsh_history
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_save_no_dups hist_ignore_all_dups hist_find_no_dups
setopt interactive_comments  # commends in interactivemode
setopt auto_menu menu_complete
setopt auto_param_slash # trailing / after directory cmp
setopt no_case_glob no_case_match # case insensitive cmp
setopt autocd 
unsetopt prompt_sp # don't clean empty lines

# general plgins 
zinit light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    marlonrichert/zsh-autocomplete \
    zsh-users/zsh-history-substring-search  \
    jeffreytse/zsh-vi-mode

# shotcut and alias plugins
zinit wait lucid light-mode for \
    OMZ::plugins/git/git.plugin.zsh \
    OMZ::plugins/kubectl/kubectl.plugin.zsh

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

## completions
export FPATH="$HOME/.config/zsh/completions/:$FPATH"

alias calc='calcpy' # https://github.com/idanpa/calcpy
alias calculator='calcpy'
alias cd='z'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -l -a'

alias t='tmux'
alias ta='tmux attach -t'
alias tnew='tmux new -s'

eval "$(direnv hook zsh)"
eval "$(dircolors -b $HOME/.dircolors)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

zvm_after_init_commands+=('eval "$(fzf --zsh)"')
# vim: ft=zsh
