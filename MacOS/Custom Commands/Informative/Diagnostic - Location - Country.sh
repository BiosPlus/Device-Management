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
# This script retrieves the country code of the current machine using the cloudflare.com API.
# It makes a curl request to the API and extracts the country code from the response.
# The retrieved country code is then printed to the console.
# This script can be used to determine the country code of the machine's IP address based on Cloudflares GEO-IP database (which is rather accurate).

loc=$(curl -s https://cloudflare.com/cdn-cgi/trace | grep -oE 'loc=[^ ]+' | cut -d'=' -f2)
echo "$loc"
