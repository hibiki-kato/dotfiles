wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > warpdotdev.gpg
sudo install -D -o root -g root -m 644 warpdotdev.gpg /etc/apt-get/keyrings/warpdotdev.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt-get/keyrings/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" > /etc/apt-get/sources.list.d/warpdotdev.list'
sudo apt-get update
sudo apt-get install -y warp-terminal
rm -f warpdotdev.gpg