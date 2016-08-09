#!/bin/bash

# Section 1.1: Check for software updates
echo "Section 1.1: Check for software updates"
echo "------------------------------------------------------------------------"
echo "Find a list of software with available updates"
echo "Output:"
softwareupdate --list
echo "\nNotes:"
echo "Use the following command to update any software:"
echo "\"sudo softwareupdate -i <packagename>\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 1.2: Enable auto-update
echo "Section 1.2: Enabling auto-update"
echo "------------------------------------------------------------------------"
echo "Check that the system will automatically check for updates."
echo "Output:"
defaults read /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled
echo "\nNotes:"
echo "Result should be 1. If output does not match use the following command:"
echo "\"sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -int 1\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 1.3: Enable app update installs
echo "Section 1.3: Enabling app update installs"
echo "------------------------------------------------------------------------"
echo "Check that app updates are installed when they are available."
echo "Output:"
defaults read /Library/Preferences/com.apple.commerce AutoUpdate
echo "\nNotes:"
echo "Result should be 1. If output does not match use the following command:"
echo "\"sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE\""
echo "(Note: Log out and log back in before changes will be seen in GUI.)"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 1.4:Enable system data files and security update installs
echo "Section 1.4: Enable software updates for system data files."
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.SoftwareUpdate | egrep '(ConfigDataInstall|CriticalUpdateInstall)'
echo "\nNotes:"
echo "Results should be 1. If output does not match use the following command:"
echo "\"sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true && sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 1.5: Enable OS X update installs
echo "Section 1.5: Enable OS X update installs"
echo "------------------------------------------------------------------------"
echo "Check that OS X updates are automatically installed."
echo "Output:"
defaults read /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired
echo "\nNotes:"
echo "Results should be 1. If output does not match use the following command:"
echo "\"sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool TRUE\""
echo "------------------------------------------------------------------------"
echo "\n"
