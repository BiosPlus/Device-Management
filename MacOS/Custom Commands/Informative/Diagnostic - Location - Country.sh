#!/bin/bash
# This script retrieves the country code of the current machine using the cloudflare.com API.
# It makes a curl request to the API and extracts the country code from the response.
# The retrieved country code is then printed to the console.
# This script can be used to determine the country code of the machine's IP address based on Cloudflares GEO-IP database (which is rather accurate).

loc=$(curl -s https://cloudflare.com/cdn-cgi/trace | grep -oE 'loc=[^ ]+' | cut -d'=' -f2)
echo "$loc"
