source $BYOBU_PREFIX/share/byobu/profiles/tmux
# Screensaver settings: 600 seconds (10 minutes) idle time
set -g lock-after-time 600
# Run pipes.sh locally, but just blank the screen over SSH to save bandwidth
set -g lock-command 'if [ -n "$SSH_CONNECTION" ]; then tput civis && clear && read -s -n 1; tput cnorm; else pipes.sh; fi'
