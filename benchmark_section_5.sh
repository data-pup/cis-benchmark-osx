#!/bin/bash

# Section 5.1.1: Audit home folder permissions
echo "Section 5.1.1: Audit home folder permissions"
echo "------------------------------------------------------------------------"
echo "Output:"
ls -l /Users/
echo "\nNotes:"
echo "Verify the value returned is either: drwx------ or drwx--x--x"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R og-rwx /Users/<username>\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.1.2: Audit System-wide Application permissions
echo "Section 5.1.2: Audit System-wide Application permissions"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo find /Applications -iname "*\.app" -type d -perm -2 -ls
echo "\nNotes:"
echo "Any applications discovered should be removed or changed."
echo "If changed the results should look like this: drwxr-xr-x"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R o-w /Applications/Bad\ Permissions.app/\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.1.3: Check System directory permissions
echo "Section 5.1.3: Check System directory permissions"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo find /System -type d -perm -2 -ls | grep -v "Public/Drop Box"
echo "\nNotes:"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R o-w /Bad/Directory\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.1.4: Check Library directory permissions
echo "Section 5.1.4: Check Library directory permissions"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo find /Library -type d -perm -2 -ls | grep -v "Caches"
echo "\nNotes:"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R o-w /Bad/Directory\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.1: Configure account lockout threshold
echo "Section 5.2.1: Configure account lockout threshold"
echo "------------------------------------------------------------------------"
echo "Output:"
pwpolicy -getaccountpolicies | grep -A 1 '<key>policyAttributeMaximumFailedAuthentications</key>' | tail -1 | cut -d'>' -f2 | cut -d '<' -f1
echo "\nNotes:"
echo "Verify the value returned is 5 or lower."
echo "Perform the following to implement the prescribed state:"
echo "\"pwpolicy -setaccountpolicies\""
echo "(NOTE: Refer to the pwpolicy man page for examples.)"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.: Show account policies
echo "Section 5.2: Show account policies"
echo "------------------------------------------------------------------------"
echo "Printing password policies..."
echo "Output:"
pwpolicy -getaccountpolicies
echo "\nNotes:"
echo "Refer to the pwpolicy man page for more configuration examples."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.3: Reduce the sudo timeout period
echo "Section 5.3: Reduce the sudo timeout period"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo cat /etc/sudoers | grep timestamp
echo "\nNotes:"
echo "Verify the value returned is: Defaults timestamp_timeout=0"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo visudo\""
echo "In the \"# Defaults specification\" section, add the line:"
echo "\"Defaults timestamp_timeout=0\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.4: Lock keychain for inactivity
echo "Section 5.4: Lock keychain for inactivity"
echo "------------------------------------------------------------------------"
echo "Output:"
security show-keychain-info
echo "\nNotes:"
echo "Verify that a value is returned below 6 hours: Keychain \"<NULL>\" timeout=21600s"
echo "Perform the following to implement the prescribed state:"
echo "Edit keychain settings in the Utilities > Keychain Access application."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.5: Lock keychain on sleep
echo "Section 5.5: Lock keychain on sleep"
echo "------------------------------------------------------------------------"
echo "Output:"
security show-keychain-info
echo "\nNotes:"
echo "Verify that the value returned contains: Keychain \"<NULL>\" lock-on-sleep"
echo "Perform the following to implement the prescribed state:"
echo "Edit keychain settings in the Utilities > Keychain Access application."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.6: Enable OCSP and CRL Certificate checks
echo "Section 5.6: Enable OCSP and CRL Certificate checks"
echo "------------------------------------------------------------------------"
echo "Auditing CSL and OCSP..."
echo "Note: This may fail while running as root."
echo "Output:"
defaults read com.apple.security.revocation CRLStyle
defaults read com.apple.security.revocation OCSPStyle
echo "\nNotes:"
echo "Perform the following to implement the prescribed state:"
echo "\"defaults write com.apple.security.revocation CRLStyle -string RequireIfPresent\""
echo "\"defaults write com.apple.security.revocation OCSPStyle -string RequireIfPresent\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.6: Do not enable the root account
echo "Section 5.6: Do not enable the root account"
echo "------------------------------------------------------------------------"
echo "Output:"
dscl . -read /Users/root AuthenticationAuthority
echo "\nNotes:"
echo "Verify the value returned is: \"No such key: AuthenticationAuthority\""
echo "Perform the following to implement the prescribed state:"
echo "Open System Preferences, Uses & Groups. Click the lock icon to unlock it."
echo "In the Network Account Server section, click Join or Edit."
echo "Click Open Directory Utility. Click the lock icon to unlock it."
echo "Select the Edit menu > Disable Root User."
echo "Note: Some legacy posix software might expect an available root account."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.8: Disable automatic login
echo "Section 5.8: Disable automatic login"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read /Library/Preferences/com.apple.loginwindow | grep autoLoginUser
echo "\nNotes:"
echo "Verify that no value is returned"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.9: Require password to wake from sleep or screensaver
echo "Section 5.9: Require password to wake from sleep or screensaver"
echo "------------------------------------------------------------------------"
echo "Output:"
defaults read com.apple.screensaver askForPassword
echo "\nNotes:"
echo "Verify the value returned is 1."
echo "Perform the following to implement the prescribed state:"
echo "defaults write com.apple.screensaver askForPassword -int 1"
echo "Note: Log off and back on for changes to take effect."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.10: Require administrator password to access System Preferences
echo "Section 5.10: Require administrator password to access System Preferences"
echo "------------------------------------------------------------------------"
echo "Output:"
security authorizationdb read system.preferences 2> /dev/null | grep -A1 shared | grep -E '(true|false)'
echo "\nNotes:"
echo "The response returned should be \"<false/>\""
echo "Perform the following to implement the prescribed state:"
echo "In System Preferences > Security > General > Advanced:"
echo "Check \"Require an administrator password to access system-wide preferences\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.11: Disable ability to login into another user's active+locked session
echo "Section 5.11: Disable ability to login into another user's active+locked session"
echo "------------------------------------------------------------------------"
echo "Output:"
grep -i "group=admin,wheel fail_safe" /etc/pam.d/screensaver
echo "\nNotes:"
echo "No results will be returned if the system is configured as recommended."
echo "Perform the following to implement the prescribed state:"
echo "\t1. sudo vi /etc/pam.d/screensaver"
echo "\t2. Locate account required pam_group.so no_warn group=admin,wheel fail_safe"
echo "\t3. Remove \"admin,\""
echo "\t4. Save"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.18: Check System-Integrity-Protection (SIP) status
echo "Section 5.18: Check System-Integrity-Protection (SIP) status"
echo "------------------------------------------------------------------------"
echo "Output:"
/usr/bin/csrutil status
echo "\nNotes:"
echo "The output should be: System Integrity Protection status: enabled."
echo "To remediate this, refer to OS X Documentation for enabling SIP."
echo "------------------------------------------------------------------------"
echo "\n"
