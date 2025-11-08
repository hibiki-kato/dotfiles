#!/bin/zsh

# Set the default values for the Dock and menu bar appearance
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6

# Screen shots
defaults write com.apple.screencaptureui "thumbnailExpiration" -float 10 # Set the thumbnail expiration time to 10 seconds
defaults write com.apple.screencapture location -string "/Users/hibiki/Library/CloudStorage/Dropbox/ScreenShots" # Save screenshots


# Finder
defaults write com.apple.Finder QuitMenuItem -boolean true # Show "Quit Finder" in the Finder menu
defaults write com.apple.finder AppleShowAllFiles -bool true # Show hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # Show all file extensions
defaults write com.apple.finder ShowPathbar -bool true # Show the path bar
defaults write com.apple.finder ShowStatusBar -bool true # Show the status bar
defaults write com.apple.finder ShowItemInfo -bool true # Show item info
defaults write com.apple.finder CreateDesktop -bool false # Hide desktop icons
defaults write com.apple.desktopservices DSDontWriteNetworkStores True # Don't create .DS_Store files on network volumes
# Set search scope.
# This Mac       : `SCev`# Current Folder : `SCcf`# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope SCcf
# Set preferred view style.
# Icon View   : `icnv`# List View   : `Nlsv`# Column View : `clmv`# Cover Flow  : `Flwv`
defaults write com.apple.finder FXPreferredViewStyle Nlsv
find . -name '.DS_Store' -type f -ls -delete
# Set default path for new windows.
# Computer     : `PfCm` # Volume       : `PfVo` # $HOME        : `PfHm`
# Desktop      : `PfDe` # Documents    : `PfDo` # All My Files : `PfAF` # Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget PfHm
killall Finder

# Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true # Enable the Debug menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true # Enable the Develop menu and the Web Inspector

# Mail
defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes # Disable inline attachment viewing
defaults write com.apple.mail SendFormat Plain # Send emails in plain text format