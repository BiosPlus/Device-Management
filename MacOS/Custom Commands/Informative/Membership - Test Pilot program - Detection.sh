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