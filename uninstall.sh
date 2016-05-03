#!/bin/sh
set -e

# Delete the printer
lpadmin -x HSR

# remove the backend
rm -s /opt/hsr-email-print/hsr-email-print /usr/lib/cups/backend/hsr-email-print
