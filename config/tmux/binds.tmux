# Change Panes Quickly (M=Alt)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# set vi
set-window-option -g mode-keys vi

# https://unix.stackexchange.com/questions/478922/tmux-select-and-copy-pane-text-with-mouse
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection primary -filter | xclip -selection clipboard"

# vi binds for copy mode
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

# splits
unbind '"'
unbind %
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# vim: filetype=tmux
