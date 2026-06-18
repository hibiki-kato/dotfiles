#!/usr/bin/env zsh
set -euo pipefail

media_user="${SUDO_USER:-${USER:-hibiki}}"
media_uid="$(id -u "$media_user")"
runtime_dir="/run/user/${media_uid}"

sudo install -d -m 755 /usr/local/bin
cat <<EOF | sudo tee /usr/local/bin/media-key-action >/dev/null
#!/usr/bin/env bash
set -euo pipefail

media_user="${media_user}"
media_uid="${media_uid}"
runtime_dir="/run/user/\${media_uid}"

run_as_user() {
  /usr/sbin/runuser -u "\$media_user" -- env \\
    XDG_RUNTIME_DIR="\$runtime_dir" \\
    DBUS_SESSION_BUS_ADDRESS="unix:path=\$runtime_dir/bus" \\
    "\$@"
}

case "\${1:-}" in
  previous)
    run_as_user /usr/bin/playerctl previous
    ;;
  next)
    run_as_user /usr/bin/playerctl next
    ;;
  play-pause)
    run_as_user /usr/bin/playerctl play-pause
    ;;
  mute)
    run_as_user /usr/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  volume-down)
    run_as_user /usr/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  volume-up)
    run_as_user /usr/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    ;;
  *)
    echo "usage: media-key-action previous|next|play-pause|mute|volume-down|volume-up" >&2
    exit 2
    ;;
esac
EOF
sudo chmod 755 /usr/local/bin/media-key-action

sudo install -d -m 755 /etc/triggerhappy/triggers.d
cat <<'EOF' | sudo tee /etc/triggerhappy/triggers.d/media-keys.conf >/dev/null
KEY_PREVIOUSSONG 1 /usr/local/bin/media-key-action previous
KEY_NEXTSONG     1 /usr/local/bin/media-key-action next
KEY_PLAYPAUSE    1 /usr/local/bin/media-key-action play-pause
KEY_MUTE         1 /usr/local/bin/media-key-action mute
KEY_VOLUMEDOWN   1 /usr/local/bin/media-key-action volume-down
KEY_VOLUMEDOWN   2 /usr/local/bin/media-key-action volume-down
KEY_VOLUMEUP     1 /usr/local/bin/media-key-action volume-up
KEY_VOLUMEUP     2 /usr/local/bin/media-key-action volume-up
EOF

sudo install -d -m 755 /etc/systemd/system/triggerhappy.service.d
cat <<'EOF' | sudo tee /etc/systemd/system/triggerhappy.service.d/override.conf >/dev/null
[Service]
ExecStart=
ExecStart=/usr/sbin/thd --triggers /etc/triggerhappy/triggers.d/ --socket /run/thd.socket --deviceglob /dev/input/event*
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now triggerhappy.service
sudo systemctl restart triggerhappy.service
