
# Default statusbar color
set-option -g status-style bg=${statusbar_bg},fg=${statusbar_fg}

set-option -g status-left "\
#[fg=${prefix_off_fg}, bg=${prefix_off_bg}]#{?client_prefix,#[fg=${prefix_on_fg} bg=${prefix_on_bg}],} ❐ #S \
#[bg=${statusbar_bg}] "

set-option -g status-right "\
#[fg=${inactive_tab_text}, bg=${inactive_tab}] %H:%M\
#[fg=${inactive_tab} bg=${statusbar_bg}]▋\
#[fg=${prefix_off_fg} bg=${prefix_off_bg}] %b %d %Y\
#[fg=${prefix_off_bg} bg=${statusbar_bg}]▋\
#[fg=${statusbar_bg} bg=${active_tab}] #{host_short} "

# active tab
set-window-option -g window-status-current-format "\
#[fg=${active_text}, bg=${active_tab}]#{?window_zoomed_flag, 🔍,} #I │\
#[fg=${active_text}, bg=${active_tab}, bold] #W \
#[fg=${active_tab}, bg=${statusbar_bg}]▌"

# inactive tab
set-window-option -g window-status-format "\
#[fg=${inactive_tab_text},bg=${inactive_tab}]#{?window_zoomed_flag, 🔍,} #I │\
#[fg=${inactive_tab_text}, bg=${inactive_tab}] #W \
#[fg=${inactive_tab}, bg=${statusbar_bg}]▌"

setw -g window-status-separator ""
# vim: filetype=tmux
