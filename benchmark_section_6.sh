#!/bin/bash

# Section 6.1.1: Display login window as name and password
echo "Section 6.1.1: Display login window as name and password"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.loginwindow SHOWFULLNAME
echo "\nNotes:"
echo "Make sure the value returned is 1."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool yes\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 6.1.2: Disable 'Show Password' hints
echo "Section 6.1.2: Disable 'Show Password' hints"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.loginwindow RetriesUntilHint
echo "\nNotes:"
echo "Make sure the value returned is 0."
echo "If the "The domain/default pair... does not exist" the computer is compliant."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 6.1.3: Disable guest account login
echo "Section 6.1.3: Disable guest account login"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo defaults read /Library/Preferences/com.apple.loginwindow.plist GuestEnabled
echo "\nNotes:"
echo "Make sure the value returned is 0."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 6.1.4: Disallow guests from connecting to shared folders
echo "Section 6.1.4: Disallow guests from connecting to shared folders"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "AFP Sharing Audit:"
defaults read /Library/Preferences/com.apple.AppleFileServer | grep -i guest
echo "SMB Sharing Audit:"
defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server | grep -i guest
echo "\nNotes:"
echo "Make sure the value returned contains guestAccess = 0;"
echo "If the "The domain/default pair... does not exist" the computer is compliant"
echo "To implement the prescribed state for AFP and SMB sharing:"
echo "\"sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool no\""
echo "\"sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool no\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 6.2: Turn on filename extensions
echo "Section 6.2: Turn on filename extensions"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read NSGlobalDomain AppleShowAllExtensions
echo "\nNotes:"
echo "The output should be 1"
echo "Perform the following to implement the prescribed state:"
echo "Check \"Show all filename extensions\" in Finder > Preferences"
echo "Note: This is user-level configuration."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 6.3: Disable automatic run of safe files in Safari
echo "Section 6.3: Disable automatic run of safe files in Safari"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read com.apple.Safari AutoOpenSafeDownloads
echo "\nNotes:"
echo "The result should be 0"
echo "Perform the following to implement the prescribed state:"
echo "\"defaults write com.apple.Safari AutoOpenSafeDownloads -boolean no\""
echo "------------------------------------------------------------------------"
echo "\n"
