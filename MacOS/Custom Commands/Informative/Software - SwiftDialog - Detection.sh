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


# Run dialog --version and capture the output
version_number=$(/usr/local/bin/dialog --version)

# Compare the version number with desired version of 2.5.0
# If installed version number is desired, output true, if outdated, output false
if [[ "$version_number" < "2.5.0" ]]; then
    echo "False"
else
    echo "True"
fi