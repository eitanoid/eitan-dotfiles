# Change Panes Quickly (M=Alt)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# set vi
set-window-option -g mode-keys vi

# https://unix.stackexchange.com/questions/478922/tmux-select-and-copy-pane-text-with-mouse
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-no-clear "xclip -selection primary -filter | xclip -selection clipboard"

# vi binds for copy mode
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection
bind-key -T copy-mode-vi Y send-keys -X copy-line \; display-message 'copied-line'

# attempt to bind yy to copy line and retain copy-selection functionality
# bind-key -T test-table q switch-client -T root  # Return to normal
# bind-key -T copy-mode-vi y switch-client -T test-table \; send-keys -X copy-selection
# bind-key -T test-table y send-keys -X copy-line \; send-keys -X copy-selection-pipe ""

bind-key -T copy-mode-vi DoubleClick1Pane send-keys -X select-line

# splits
unbind '"'
unbind %
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# vim: filetype=tmux
