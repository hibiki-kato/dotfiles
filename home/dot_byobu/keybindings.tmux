# Managed by chezmoi. Do not edit directly. Update via chezmoi, using OS/host-specific partitioning when needed.
bind-key -n C-t new-window -c "#{pane_current_path}" \; rename-window "-"
bind-key -n F5 display-panes \; split-window -h -c "#{pane_current_path}"
bind-key -n F6 display-panes \; split-window -v -c "#{pane_current_path}"
bind-key -n F9 detach

# F1 as sticky prefix for pane navigation (stay in pane-nav until non-arrow key)
bind-key -n F1 switch-client -T pane-nav
bind-key -T pane-nav Up    select-pane -U \; switch-client -T pane-nav
bind-key -T pane-nav Down  select-pane -D \; switch-client -T pane-nav
bind-key -T pane-nav Left  select-pane -L \; switch-client -T pane-nav
bind-key -T pane-nav Right select-pane -R \; switch-client -T pane-nav

set -g prefix C-b
set -g prefix2 F12
bind b send-prefix
