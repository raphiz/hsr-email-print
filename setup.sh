#!/bin/sh
set -e

# Link the backend & set permissions
ln -s /opt/hsr-email-print/hsr-email-print /usr/lib/cups/backend/hsr-email-print
chmod 700 /usr/lib/cups/backend/hsr-email-print
chown root:root /usr/lib/cups/backend/hsr-email-print

# Add the printer
lpadmin -p HSR -E -v hsr-email-print:/tmp -P /opt/hsr-email-print/Generic-PostScript_Printer-Postscript.ppd
