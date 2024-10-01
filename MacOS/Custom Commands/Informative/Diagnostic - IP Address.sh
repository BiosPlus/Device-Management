#!/bin/bash
# This script retrieves the IP address of the current machine using the cloudflare.com API.
# It makes a curl request to the API and extracts the IP address from the response.
# The retrieved IP address is then printed to the console.
# This works for ipv4 and ipv6 addresses.

ip_address=$(curl -s https://cloudflare.com/cdn-cgi/trace | grep -oE 'ip=[^ ]+' | cut -d'=' -f2)
echo "$ip_address"
