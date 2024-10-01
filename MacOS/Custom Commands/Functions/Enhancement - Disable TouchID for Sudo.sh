#!/bin/bash

# This script is designed to disable Touch ID authentication for sudo on macOS 14.x
# and later. It does this by checking for and removing the following file:
#
# /etc/pam.d/sudo_local

os_version=$(sw_vers --productVersion)
os_version_check=$(echo "$os_version" | awk -F. '{print $1}')
touch_id_auth_file="/etc/pam.d/sudo_local"

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

# Set exit status

exitCode=0

# Verify that Mac is running macOS 14.x or later

if [[ "$os_version_check" -ge 14 ]]; then

   if [[ -f "$touch_id_auth_file" ]]; then
      /bin/rm "$touch_id_auth_file"
   fi

else

  # If Mac is running macOS 13.x or earlier, display a message that this script cannot be used
  # on this Mac to disable Touch ID authorization for sudo. 

  echo "This Mac is running $os_version. This script is not able to disable Touch ID authorization for sudo on this macOS version."
  exitCode=1
fi

exit "$exitCode"