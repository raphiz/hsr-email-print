#!/usr/bin/env bash
set -e

# Delete the printer - if it exists...
set +e
lpstat -a HSR 2&> /dev/null
if [ $? -eq 0 ]; then
    echo "Removing printer HSR"
    lpadmin -x HSR
fi
set -e
# remove the backend
if [ -e "/usr/lib/cups/backend/hsr-email-print" ]; then
    echo "Removing backend hsr-email-print"
    rm /usr/lib/cups/backend/hsr-email-print
fi
