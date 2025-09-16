# C++

## install gcc
```bash
brew install gcc
```

## set symbolic link
```bash
sudo ln -sf /opt/homebrew/bin/gcc-15 /usr/local/bin/gcc
sudo ln -sf /opt/homebrew/bin/g++-15 /usr/local/bin/g++
```

## If /usr/local/bin is not prioritized
add 
```bash
export PATH="/usr/local/bin:$PATH"
```
to prioritize `/usr/local/bin` than `/usr/bin` in your PATH.

to ~/.zshrc and then
```bash
source ~/.zshrc
```