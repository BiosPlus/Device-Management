#!/bin/bash
# This is used for measuring the amount of enroled fingerprints on a Mac via TouchID
# Get the number of enrolled fingerprints using bioutil -sc
# It will output the amount of fingerprints enrolled as a number, there is a maximum of 3 fingerprints on a user account, and 5 fingerprints on a Mac.
# If no fingerprints are enrolled, it will output 0

fingerprints=$(/usr/bin/bioutil -sc | awk -F ':' '/biometric template\(s\)/ {print $2}' | awk '{print $1}')
echo "${fingerprints:-0}"