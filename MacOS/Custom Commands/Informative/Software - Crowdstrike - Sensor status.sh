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
# Define variables
FALCONCTL_PATH="/Applications/Falcon.app/Contents/Resources/falconctl"
SENSOR_ERROR="Error: The sensor has not loaded."
SENSOR_NOT_OPERATIONAL="Sensor operational: false"

# Check the status of the sensor and load it if necessary
function check_sensor_status {
    if $FALCONCTL_PATH stats 2>&1 | grep -q "$SENSOR_ERROR"; then
        echo "Sensor not loaded"
        load_sensor
    elif $FALCONCTL_PATH stats 2>&1 | grep -q "$SENSOR_NOT_OPERATIONAL"; then
        echo "Sensor not operational"
        exit 1
    else
        echo "Sensor operational"
    fi
}

# Load the sensor
function load_sensor {
    local i=0
    while [ $i -lt 3 ]
    do
        $FALCONCTL_PATH load
        if $FALCONCTL_PATH stats 2>&1 | grep -q "$SENSOR_ERROR"; then
            echo "Sensor not loaded"
        elif $FALCONCTL_PATH stats 2>&1 | grep -q "$SENSOR_NOT_OPERATIONAL"; then
            echo "Sensor not operational"
        else
            echo "Sensor operational"
            break
        fi
        i=$((i+1))
    done
    if [ $i -eq 3 ]; then
        echo "Critical Fail"
        exit 1
    fi
}

# Check if falconctl exists and call check_sensor_status
function check_falconctl {
    if [ -x "$FALCONCTL_PATH" ]; then
        check_sensor_status
    else
        echo "falconctl does not exist"
        exit 1
    fi
}

# Call check_falconctl
check_falconctl