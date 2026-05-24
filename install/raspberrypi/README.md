# Raspberry Pi Install Profile

This profile targets Raspberry Pi OS with a GUI.

It installs lightweight CLI/development basics, Pi-Apps apps (RustDesk and Brave), Docker, a RustDesk server under `/opt/rustdesk-server`, Tailscale, and Japanese input via fcitx5-mozc.

## RustDesk self-host server over Tailscale

The install profile creates `/opt/rustdesk-server/compose.yml` and starts `hbbs` and `hbbr` via:

```sh
scripts/raspberrypi/rustdesk-server.sh setup
```

No router port forwarding, public DNS, public IP, or public firewall rules are needed when every client is connected to the same Tailscale tailnet.

By default, the setup script detects the Pi's Tailscale IPv4 address with `tailscale ip -4` and writes it only to `/opt/rustdesk-server/compose.yml` on that machine.

To override the detected address locally, set:

```sh
RUSTDESK_TAILSCALE_HOST=<tailscale-host-or-100.x.y.z> scripts/raspberrypi/rustdesk-server.sh setup
```

The RustDesk ports only need to be reachable over Tailscale:

```text
TCP 21115
TCP/UDP 21116
TCP 21117
TCP 21118
TCP 21119
```

Client settings:

```text
ID Server: <Pi Tailscale IP or MagicDNS name>
Relay Server: <Pi Tailscale IP or MagicDNS name>
Key: output of scripts/raspberrypi/rustdesk-server.sh key
```
