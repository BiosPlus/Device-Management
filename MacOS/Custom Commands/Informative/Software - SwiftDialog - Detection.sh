#!/bin/bash

# Run dialog --version and capture the output
version_number=$(/usr/local/bin/dialog --version)

# Compare the version number with desired version of 2.5.0
# If installed version number is desired, output true, if outdated, output false
if [[ "$version_number" < "2.5.0" ]]; then
    echo "False"
else
    echo "True"
fi