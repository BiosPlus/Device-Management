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
# Get the current console user
currentUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }' )

# Check if a user is logged in
if [ "$currentUser" == "loginwindow" ] || [ -z "$currentUser" ]; then
  echo "No user logged in."
  exit 1
fi

# echo currentUser is $currentUser

# Get the current user's UID
uid=$(id -u "$currentUser")
# echo uid is $uid

# Run a command as the current user
# usage:
#   runAsUser command arguments...
runAsUser() {
  launchctl asuser "$uid" sudo -u "$currentUser" "$@"
}

# Function to check if the MobileMe file exists
checkFileExists() {
  if [ -f "/Users/$currentUser/Library/Preferences/MobileMeAccounts.plist" ]; then
    # echo "File exists."
    return 0
  else
    exit 1
  fi
}

# Function to get the AppleID from the MobileMe file
getAppleID() {
  appleID=$(runAsUser /usr/libexec/PlistBuddy -c "print :Accounts:0:AccountID" "/Users/$currentUser/Library/Preferences/MobileMeAccounts.plist")
  if [ -n "$appleID" ]; then
    echo "$appleID"
  else
    exit 1
  fi
}

# Call the functions in order
checkFileExists
getAppleID