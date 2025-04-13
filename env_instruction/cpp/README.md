# C++

## install gcc
```bash
brew install gcc
```

## set symbolic link
```bash
ln -s /opt/homebrew/bin/gcc-14 /usr/local/bin/gcc
ln -s /opt/homebrew/bin/g++-14 /usr/local/bin/g++
```

## If /usr/local/bin is not prioritized
add 
```bash
export PATH="/usr/local/bin:$PATH"
```

to ~/.zshrc and then
```bash
source ~/.zshrc
```