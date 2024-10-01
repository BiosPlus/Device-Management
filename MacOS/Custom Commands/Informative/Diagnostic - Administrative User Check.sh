#!/bin/bash

# Check if the current user is in the admin group
if dseditgroup -o checkmember -m "%EmailPrefix%" admin &>/dev/null; then
    echo "Current user (%EmailPrefix%) is in the admin group."
else
    echo "Current user (%EmailPrefix%) is not in the admin group."
fi

