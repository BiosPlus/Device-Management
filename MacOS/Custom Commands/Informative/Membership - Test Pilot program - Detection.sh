#!/bin/bash
# This script is used for Device Grouping to check whether the user has joined the Test Pilot program.
# The detection rule should be something like 'Command Output = 1 = True' in Mosyle

# Get the current console user
currentUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }' )

# Check if a user is logged in
if [ "$currentUser" == "loginwindow" ] || [ -z "$currentUser" ]; then
  exit 1
fi

# Get the current user's UID
uid=$(id -u "$currentUser")

# Run a command as the current user
# usage:
#   runAsUser command arguments...
runAsUser() {
  launchctl asuser "$uid" sudo -u "$currentUser" "$@"
}

# Verify the change (optional)
result=$(runAsUser defaults read /Users/$currentUser/Library/Preferences/tld.domain.user TestPilot 2>/dev/null)

if [ "$result" == "1" ]; then
  echo "True"
  exit 0
else
  echo "False"
  exit 1
fi