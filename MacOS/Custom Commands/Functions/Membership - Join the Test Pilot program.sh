#!/bin/bash
#####
# Script by: Jon Black
# Website: jonblack.gg
# License: GNU AGPL v3 (https://www.gnu.org/licenses/agpl-3.0.en.html)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# You must provide attribution (this notice must remain intact),
# and any modifications must also be shared under the same license.
# If you run this program on a server and modify it, you must also
# make your modifications publicly available.
#
# NO WARRANTY: This software is provided "as-is" without any guarantees.
#####
# This script sets a key-value pair in a plist file (at ~/Library/Preferences/com.domain.user, TestPilot) for the current user.
# If the key is set successfully, the script will print "TestPilot key set to true successfully."
# This is to be paired with a device group command which will check if the key is set to true and join the device to the TestPilot group should the value = 1

# Get the current console user
currentUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }' )

# Check if a user is logged in
if [ "$currentUser" == "loginwindow" ] || [ -z "$currentUser" ]; then
  echo "No user logged in."
  exit 1
fi

echo currentUser is $currentUser

# Get the current user's UID
uid=$(id -u "$currentUser")
echo uid is $uid

# Run a command as the current user
# usage:
#   runAsUser command arguments...
runAsUser() {
  launchctl asuser "$uid" sudo -u "$currentUser" "$@"
}

# Set the key-value pair in the plist file
runAsUser defaults write /Users/$currentUser/Library/Preferences/tld.domain.user TestPilot -bool true

# Verify the change (optional)
result=$(runAsUser defaults read /Users/$currentUser/Library/Preferences/tld.domain.user TestPilot 2>/dev/null)
if [ "$result" == "1" ]; then
  echo "TestPilot key set to true successfully."
  runAsUser /usr/local/bin/dialog --notification --title "Test Pilot Program" --message "You have successfully enrolled into the Test Pilot program.\nIf this was done in error, please inform IT to unenroll you."
else
  echo "Failed to set TestPilot key."
  exit 1
fi
