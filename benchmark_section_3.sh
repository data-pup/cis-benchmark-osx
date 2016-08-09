#!/bin/bash

# Section 3.1.1: Check system.log configuration
echo "Section 3.1.1: Check system.log configuration"
echo "------------------------------------------------------------------------"
echo "Output:"
grep -i ttl /etc/asl.conf
echo "\nNotes:"
echo "Verify that the ttl for system.log is greater than 90 days."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo vim /etc/asl.conf\""
echo "Replace or edit the current setting with a compliant setting such as:"
echo "system.log mode=0640 format=bsd rotate=utc compress file_max=5M ttl=90"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 3.1.2: Check appfirewall.log configuration
echo "Section 3.1.2: Check appfirewall.log configuration"
echo "------------------------------------------------------------------------"
echo "Output:"
grep -i ttl /etc/asl.conf
echo "\nNotes:"
echo "Verify that the ttl for system.log is greater than 90 days."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo vim /etc/asl.conf\""
echo "Replace or edit the current setting with a compliant setting such as:"
echo "appfirewall.log mode=0640 format=bsd rotate=utc compress file_max=5M ttl=90"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.1.3: Check authd.log configuration
echo "Section 3.1.3: Check authd.log configuration"
echo "------------------------------------------------------------------------"
echo "Output:"
grep -i ttl /etc/asl/com.apple.authd
echo "\nNotes:"
echo "Verify that the ttl for system.log is greater than 90 days."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo vim /etc/asl/com.apple.authd\""
echo "Replace or edit the current setting with a compliant setting such as:"
echo "* file /var/log/authd.log mode=0640 format=bsd rotate=utc compress file_max=5M ttl=90"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.2: Enable security auditing
echo "Section 3.2: Enable security auditing"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo launchctl list | grep -i auditd
echo "\nNotes:"
echo "Verify that \"com.apple.auditd\" appears."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.3: Configure security auditing flags
echo "Section 3.3: Configure security auditing flags"
echo "------------------------------------------------------------------------"
echo "Output:"
sudo egrep "^flags:" /etc/security/audit_control
echo "\nNotes:"
echo "Verify that at least the following flags are present:"
echo "\tlo - audit successful/failed login/logout events"
echo "\tad - audit successful/failed administrative events"
echo "\tfd - audit successful/failed file deletion events"
echo "\tfm - audit successful/failed file attribute modification events"
echo "\t-all - audit all failed events across all audit classes"
echo "Perform the following to implement the prescribed state:"
echo "Open the /etc/security/audit_control file and find the flags line."
echo "Add the lo, ad, fd, fm, -all flags."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.5: Retain install.log configuration
echo "Section 3.3: install.log retaining configuration"
echo "------------------------------------------------------------------------"
echo "Output:"
grep -i ttl /etc/asl/com.apple.install
echo "\nNotes:"
echo "Verify that ttl is 365 or higher for install.log"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo vim /etc/asl/com.apple.install\""
echo "Replace the current setting with a compliant setting such as:"
echo "* file /var/log/install.log mode=0640 format=bsd rotate=utc compress file_max=5M ttl=365"
echo "------------------------------------------------------------------------"
echo "\n"
