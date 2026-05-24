# Raspberry Pi Install Profile

This profile targets Raspberry Pi OS with a GUI.

It installs lightweight CLI/development basics, Pi-Apps apps (RustDesk and Brave), Docker, a RustDesk server under `/opt/rustdesk-server`, and Tailscale.

The RustDesk server setup follows the upstream OSS compose file:

```sh
bash <(wget -qO- https://get.docker.com)
wget rustdesk.com/oss.yml -O compose.yml
sudo docker compose up -d
```
