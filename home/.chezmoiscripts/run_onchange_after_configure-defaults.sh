#!/usr/bin/env bash

set -euo pipefail

# Close any open System Preferences panes
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

###############################################################################
# Misc                                                                        #
###############################################################################

[ -d ~/Desktop/screenshots ] || mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location -string "~/Desktop/screenshots" && killall SystemUIServer

###############################################################################
# Finder                                                                      #
###############################################################################

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# default to list view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# enable full keyboard navigation with Tab
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
defaults write NSGlobalDomain NSSmartReplyEnabled -bool false

###############################################################################
# Safari - ⚠️ requires Full Disk Access                                       #
###############################################################################

# show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Make Safari's search default to Contains instead of Begins With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# disallow privacy-preserving ad measurement
defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -int 0

# use advanced tracking and fingerprint protection 'in all browsing'
defaults write com.apple.Safari EnableEnhancedPrivacyInRegularBrowsing -int 1

# send Do Not Track header
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# enable developer menus
defaults write IncludeDevelopMenu -int 1
defaults write MobileDeviceRemoteXPCEnabled -int 1
defaults write DeveloperMenuVisibility -int 1
defaults write DeveloperPreferences -int 836
defaults write WebFeatureFlagSettings -int 836
defaults write WebKitDeveloperExtrasEnabledPreferenceKey -int 1
defaults write WebKitPreferences.developerExtrasEnabled -int 1

###############################################################################
# Trackpad                                                                    #
###############################################################################

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -int 1
defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# END                                                                         #
###############################################################################

killall Dock
killall Finder

echo "✨ defaults setup complete."
