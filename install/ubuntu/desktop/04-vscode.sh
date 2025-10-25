wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft.gpg
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main' \
  | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt-get update
sudo apt-get install -y code
rm -f microsoft.gpg