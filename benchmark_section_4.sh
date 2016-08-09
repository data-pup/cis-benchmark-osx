#!/bin/bash

# Section 4.1: Disable Bonjour advertising service
echo "Section 4.1: Disable Bonjour advertising service"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.alf globalstate
echo "\nNotes:"
echo "Verify the value returned is 1 or 2"
echo "Perform the following to implement the prescribed state:"
echo "(Refer to the CIS Benchmark document, this involves editing DNS config.)"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 4.2: Wifi status menu bar
echo "Section 4.2: Check Wi-Fi status in menu bar"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read com.apple.systemuiserver menuExtras | grep AirPort.menu
echo "\nNotes:"
echo "Verify the value returned is: /System/Library/CoreServices/Menu Extras/AirPort.menu"
echo "Perform the following to implement the prescribed state:"
echo "Edit \"Show Wi-Fi\" in System Preferences > Network"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 4.4: Audit http server (Should not be running)
echo "Section 4.4: Audit http server (Should not be running)"
echo "------------------------------------------------------------------------"
echo "Output:"
ps -ef | grep -i httpd
echo "\nNotes:"
echo "There should be no results for /usr/sbin/httpd"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo apachectl stop\""
echo "\"sudo defaults write /System/Library/LaunchDaemons/org.apache.httpd Disabled -bool true\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 4.5: Audit ftp server (should not be running)
echo "Section 4.5: Audit ftp server (should not be running)"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo launchctl list | egrep ftp
echo "\nNotes:"
echo "There should be no results for com.apple.ftpd"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 4.6: Audit nfs server (should not be running)
echo "Section 4.6: Audit nfs server (should not be running)"
echo "------------------------------------------------------------------------"
echo "Output:"
ps -ef | grep -i nfsd
echo "There should be no results for /sbin/nfsd"
cat /etc/exports
echo "Should return \"No such file or directory\""
echo "\nNotes:"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo nfsd disable\""
echo "\"rm /etc/export\""
echo "------------------------------------------------------------------------"
echo "\n"
