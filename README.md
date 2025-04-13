# dotfiles

## MacOS

### Install command line tools
Install command line tools for Xcode. This is required for installing git and other packages.
```sh
xcode-select --install
```
Set user name and email for git. 
```sh
git config --global user.name "Your Name"
git config --global user.email "example.com"
```

## Clone this repository
```sh
cd ~
git clone https://github.com/hibiki-kato/dotfiles.git
cd dotfiles
```

### Run startup.sh
```sh
./scripts/setup.sh
```

## How to move to a new machine

## How to maintain using cron
