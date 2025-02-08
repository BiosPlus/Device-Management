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
# This is used for measuring the amount of enroled fingerprints on a Mac via TouchID
# Get the number of enrolled fingerprints using bioutil -sc
# It will output the amount of fingerprints enrolled as a number, there is a maximum of 3 fingerprints on a user account, and 5 fingerprints on a Mac.
# If no fingerprints are enrolled, it will output 0

fingerprints=$(/usr/bin/bioutil -sc | awk -F ':' '/biometric template\(s\)/ {print $2}' | awk '{print $1}')
echo "${fingerprints:-0}"