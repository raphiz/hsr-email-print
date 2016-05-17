#!/usr/bin/env bash
set -e

# Link the backend & set permissions
if [ ! -e "/usr/lib/cups/backend/hsr-email-print" ]; then
    echo "Adding backend hsr-email-print"
    ln -s /opt/hsr-email-print/hsr-email-print /usr/lib/cups/backend/hsr-email-print
    chmod 700 /usr/lib/cups/backend/hsr-email-print
    chown root:root /usr/lib/cups/backend/hsr-email-print
fi

# Add the printer if not yet installed
set +e
lpstat -a HSR 2&> /dev/null
if [ $? -ne 0 ]; then
    set -e
    echo "Adding printer HSR"
    lpadmin -p HSR -E -v hsr-email-print:/tmp -P /opt/hsr-email-print/Generic-PostScript_Printer-Postscript.ppd
fi
