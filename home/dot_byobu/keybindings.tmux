# Managed by chezmoi. Do not edit directly. Update via chezmoi, using OS/host-specific partitioning when needed.
bind-key -n C-t new-window -c "#{pane_current_path}" \; rename-window "-"
bind-key -n F5 display-panes \; split-window -h -c "#{pane_current_path}"
bind-key -n F6 display-panes \; split-window -v -c "#{pane_current_path}"
bind-key -n F9 detach

# F1 as sticky prefix for pane navigation (stay in pane-nav until non-arrow/hjkl key)
bind-key -n F1 switch-client -T pane-nav
bind-key -T pane-nav k     select-pane -U \; switch-client -T pane-nav
bind-key -T pane-nav j     select-pane -D \; switch-client -T pane-nav
bind-key -T pane-nav h     select-pane -L \; switch-client -T pane-nav
bind-key -T pane-nav l     select-pane -R \; switch-client -T pane-nav
bind-key -T pane-nav Up    select-pane -U \; switch-client -T pane-nav
bind-key -T pane-nav Down  select-pane -D \; switch-client -T pane-nav
bind-key -T pane-nav Left  select-pane -L \; switch-client -T pane-nav
bind-key -T pane-nav Right select-pane -R \; switch-client -T pane-nav

unbind-key -n C-a
unbind-key -n C-b
set -g prefix F12
bind F12 send-prefix

# コピーモード、ペースト、ペイン削除をFキー単発に割り当て
bind-key -n F7 copy-mode
bind-key -n F8 paste-buffer
bind-key -n F10 kill-pane

# Prefix(F12) + k でペインを閉じる設定（念のため）
bind k kill-pane
