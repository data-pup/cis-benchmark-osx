#!/bin/bash

# Section 2.1 Bluetooth:
echo "Section 2.1: Audit Bluetooth settings"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState
echo "\nNotes:"
echo "Output value should be 0. If the value returned is 1, Bluetooth is enabled."
echo "If Bluetooth is enabled, use this command to see the paired devices:"
echo "\"system_profiler | grep "Bluetooth:" -A 20 | grep Connectable\""
echo "Use these commands to disable Bluetooth:"
echo "\"sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0\""
echo "\"sudo killall -HUP blued\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.1.2: Turn off Bluetooth's "Discoverable mode"
echo "Section 2.1.2: Turn off Bluetooth's \"Discoverable mode\""
echo "------------------------------------------------------------------------"
echo "Output:"
/usr/sbin/system_profiler SPBluetoothDataType | grep -i discoverable
echo "\nNotes:"
echo "Return value should be \"Off.\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.1.3: Check that Bluetooth is included in the menu bar
echo "Section 2.1.3: Check that Bluetooth is included in the menu bar"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read com.apple.systemuiserver menuExtras | grep Bluetooth.menu
echo "\nNotes:"
echo "Verify the value returned is: /System/Library/CoreServices/Menu Extras/Bluetooth.menu"
echo "To add Bluetooth to the system menu run the following command:"
echo "\"defaults write com.apple.systemuiserver menuExtras -array-add \"/System/Library/CoreServices/Menu Extras/Bluetooth.menu\"\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.2.1: Set time and date automatically
echo "Section 2.2.1: Set time and date automatically"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo systemsetup -getusingnetworktime
echo "\nNotes:"
echo "Verify that the results are: Network Time: On"
echo "If the result does not match, use the following commands:"
echo "\"sudo systemsetup -setnetworktimeserver <timeserver>\""
echo "\"sudo systemsetup –setnetworktimeserver on\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.3.1: Audit all system screensaver times
echo "Section 2.3.1: Audit all system user screensaver times"
echo "------------------------------------------------------------------------"
echo "Checking all user's screensaver times. Values should be < 1200."
echo "Output:"
UUID=`ioreg -rd1 -c IOPlatformExpertDevice | grep "IOPlatformUUID" | sed -e 's/^.*"\(.*\)"$/\1/'`
for i in $(find /Users -type d -maxdepth 1)
do
PREF=$i/Library/Preferences/ByHost/com.apple.screensaver.$UUID
if [ -e $PREF.plist ]
then
echo -n "Checking User: '$i': "
defaults read $PREF.plist idleTime 2>&1
fi
done
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.3.2: Secure screen saver corners
echo "Section 2.3.2: Secure screen saver corners"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read ~/Library/Preferences/com.apple.dock | grep -i corner
echo "\nNotes:"
echo "Verify that 6 is not returned for any key value for any user."
echo "Remove corners in System Preferences > Mission Control > Hot Corners"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.3.3: Display sleep and screensaver timer audit
echo "Section 2.3.3: Display sleep and screensaver timer audit"
echo "------------------------------------------------------------------------"
echo "Check that Display sleep is set to a larger value than screensaver:"
echo "Output:"
pmset -g | grep displaysleep
echo "\nNotes:"
echo "Check that this value is larger than the screensaver timer by going to:"
echo "System Preferences: Energy Saver, and check sliders."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.1: Disable remote Apple events
echo "Section 2.4.1: Disable remote Apple events"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo systemsetup -getremoteappleevents
echo "\nNotes:"
echo "Verify the value returned is Remote Apple Events: Off"
echo "To remedy this if the value does not match, run the following command:"
echo "\"sudo systemsetup -setremoteappleevents off\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.2: Disable Internet sharing
echo "Section 2.4.2: Disable Internet sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo defaults read /Library/Preferences/SystemConfiguration/com.apple.nat | grep -i Enabled
echo "\nNotes:"
echo "The file should not exist or Enabled = 0 for all network interfaces."
echo "Perform the following to implement the prescribed state:"
echo "Uncheck \"Internet Sharing\" in System Preferences > Sharing"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.3: Disable screen sharing
echo "Section 2.4.3: Disable screen sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo launchctl load /System/Library/LaunchDaemons/com.apple.screensharing.plist
echo "\nNotes:"
echo "Verify the value returned is Service is disabled"
echo "To fix, uncheck \"Screen Sharing\" in System Preferences > Sharing."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.4: Disable printer sharing
echo "Section 2.4.4: Disable printer sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
system_profiler SPPrintersDataType | egrep "Shared: Yes"
echo "\nNotes:"
echo "The output should be empty. If \"Shared: Yes\" is in the output there are still shared printers."
echo "To fix, uncheck \"Printer Sharing\" in System Preferences > Sharing."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.5: Disable remote login
echo "Section 2.4.5: Disable remote login"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo systemsetup -getremotelogin
echo "\nNotes:"
echo "Verify the value returned is Remote Login: Off"
echo "To implement the prescribed state run the following command:"
echo "\"sudo systemsetup -setremotelogin off\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.6: Disable DVD or CD Sharing
echo "Section 2.4.6: Disable DVD or CD Sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo launchctl list | egrep ODSAgent
echo "\nNotes:"
echo "If "com.apple.ODSAgent" appears in the result the control is not in place."
echo "To implement the prescribed state:"
echo "Uncheck \"DVD or CD Sharing\" in System Preferences > Sharing"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.7: Disable bluetooth sharing
echo "Section 2.4.7: Disable bluetooth sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
system_profiler SPBluetoothDataType | grep State
echo "\nNotes:"
echo "Verify that all values are Disabled."
echo "To implement the prescribed state:"
echo "Uncheck \"Bluetooth Sharing\" in System Preferences > Sharing"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.4.8: Disable file sharing
echo "Section 2.4.8: Disable file sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "Checking the Apple File Server status:"
sudo launchctl list | egrep AppleFileServer
echo "Checking the Windows File Server status:"
grep -i array /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist
echo "\nNotes:"
echo "Ensure no output is present"
echo "To implement the prescribed state run the following command(s):"
echo "\"sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist\""
echo "\"sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist \""
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.4.9: Disable remote management
echo "Section 2.4.9: Disable remote management"
echo "------------------------------------------------------------------------"
echo "Output:"
ps -ef | egrep ARDAgent
echo "\nNotes:"
echo "Ensure /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/MacOS/ARDAgent is not present"
echo "To implement the prescribed state:"
echo "Turn off Remote Management in System Preferences > Sharing."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.1: Disable wake for network access
echo "Section 2.5.1: Disable wake for network access"
echo "------------------------------------------------------------------------"
echo "Output:"
pmset -c -g | grep womp; pmset -b -g | grep womp
echo "\nNotes:"
echo "Verify that both values returned are 0."
echo "To implement the prescribed state run the following command:"
echo "\"sudo pmset -a womp 0\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.1: Enable FileVault
echo "Section 2.6.1: Enable FileVault"
echo "------------------------------------------------------------------------"
echo "Output:"
diskutil cs list | grep -i encryption
echo "\nNotes:"
echo "On a booted system, the Logical Volume should be both encrypted and unlocked."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.2: Enable Gatekeeper
echo "Section 2.6.2: Enable Gatekeeper"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo spctl --status
echo "\nNotes:"
echo "Ensure the above command outputs \"assessments enabled\"."
echo "To implement the prescribed state:"
echo "Manage the menu in System Preferences > Security & Priviacy > General"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.3: Enable Firewall
echo "Section 2.6.3: Enable Firewall"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.alf globalstate
echo "\nNotes:"
echo "Verify the value returned is 1 or 2"
echo "Perform the following to implement the prescribed state:"
echo "Turn on Firewall in System Preferences > Security & Privacy > Firewall"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.4: Enable Firewall Stealth Mode
echo "Section 2.6.4: Enable Firewall Stealth Mode"
echo "------------------------------------------------------------------------"
echo "Output:"
/usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode
echo "\nNotes:"
echo "Verify the value returned is Stealth mode enabled"
echo "Perform the following to implement the prescribed state:"
echo "Enable stealth mode in System Preferences > Security & Privacy > Firewall Options"
echo "or run the following command:"
echo "\"sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.5: Show Application Firewall Rules
echo "Section 2.6.5: Show Application Firewall Rules"
echo "------------------------------------------------------------------------"
echo "Output:"
/usr/libexec/ApplicationFirewall/socketfilterfw --listapps
echo "\nNotes:"
echo "The number of rules returned should be lower than 10."
echo "Perform the following to implement the prescribed state:"
echo "Manage firewall options in System Preferences > Security & Privacy > Firewall Options"
echo "or run the following command (insert Application name):"
echo "\"/usr/libexec/ApplicationFirewall/socketfilterfw --remove </Applications/badapp.app>\""
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.10: Audit default Java runtime version
echo "Section 2.10: Audit default Java runtime version"
echo "------------------------------------------------------------------------"
echo "Output:"
java -version
echo "\nNotes:"
echo "Java should not be version 6"
echo "------------------------------------------------------------------------"
echo "\n"
