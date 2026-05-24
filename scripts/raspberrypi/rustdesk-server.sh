#!/usr/bin/env zsh
set -euo pipefail

RUSTDESK_DIR="${RUSTDESK_DIR:-/opt/rustdesk-server}"
TAILSCALE_HOST="${RUSTDESK_TAILSCALE_HOST:-${RUSTDESK_RELAY_HOST:-}}"

usage() {
  cat <<'EOF'
Usage: rustdesk-server.sh [setup|start|restart|stop|status|logs|key]

Environment:
  RUSTDESK_DIR=/opt/rustdesk-server
  RUSTDESK_TAILSCALE_HOST=<optional tailscale host or 100.x.y.z>
EOF
}

require_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is required for rustdesk-server. Run install/raspberrypi/03-docker.sh first." >&2
    exit 1
  fi
  sudo docker compose version >/dev/null
}

compose_command() {
  local host="$TAILSCALE_HOST"
  if [ -z "$host" ] && command -v tailscale >/dev/null 2>&1; then
    host="$(tailscale ip -4 2>/dev/null | head -n 1 || true)"
  fi

  if [ -n "$host" ]; then
    case "$host" in
      *:*) printf 'hbbs -r %s\n' "$host" ;;
      *) printf 'hbbs -r %s:21117\n' "$host" ;;
    esac
  else
    printf 'hbbs\n'
  fi
}

write_compose() {
  sudo mkdir -p "$RUSTDESK_DIR/data"
  sudo tee "$RUSTDESK_DIR/compose.yml" >/dev/null <<EOF
services:
  hbbs:
    image: rustdesk/rustdesk-server:latest
    container_name: hbbs
    command: $(compose_command)
    volumes:
      - ./data:/root
    network_mode: host
    restart: unless-stopped

  hbbr:
    image: rustdesk/rustdesk-server:latest
    container_name: hbbr
    command: hbbr
    volumes:
      - ./data:/root
    network_mode: host
    restart: unless-stopped
EOF
}

run_compose() {
  cd "$RUSTDESK_DIR"
  sudo docker compose "$@"
}

show_key() {
  local key_file="$RUSTDESK_DIR/data/id_ed25519.pub"
  if [ ! -r "$key_file" ]; then
    echo "Key file not found yet. Run setup/start first: $key_file" >&2
    return 1
  fi
  cat "$key_file"
}

cmd="${1:-setup}"
case "$cmd" in
  setup)
    require_docker
    write_compose
    run_compose up -d
    echo "RustDesk server is running."
    echo "Public key:"
    show_key || true
    ;;
  start)
    require_docker
    run_compose up -d
    ;;
  restart)
    require_docker
    run_compose up -d --force-recreate
    ;;
  stop)
    require_docker
    run_compose down
    ;;
  status)
    require_docker
    run_compose ps
    ;;
  logs)
    require_docker
    run_compose logs -f --tail=100
    ;;
  key)
    show_key
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac
