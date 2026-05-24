# Raspberry Pi Install Profile

This profile targets Raspberry Pi OS with a GUI.

It installs lightweight CLI/development basics, Docker, RustDesk, a RustDesk server under `/opt/rustdesk-server`, and Brave Browser.

The RustDesk server setup follows the upstream OSS compose file:

```sh
bash <(wget -qO- https://get.docker.com)
wget rustdesk.com/oss.yml -O compose.yml
sudo docker compose up -d
```
