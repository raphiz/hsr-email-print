# Drucken via CUPS an der HSR

[![forthebadge](http://forthebadge.com/images/badges/built-with-swag.svg)](http://forthebadge.com)

Dieses Skript ermöglicht bequemes Drucken von alternativen Betriebssystemen an der HSR.
Es wird ein neuer Drucker names HSR installiert, mit dem du drucken kannst. Im Hintergrund
wird dann eine E-Mail an den mobileprint service der HSR gesendet.

## Disclaimer
Dieses inoffizielle Skript ist auf eigene Gefahr zu verwenden!

## Installation

Python3 muss auf dem system installiert sein!

Führe folgende Kommandos schritt für schritt aus.
*Ersetze die E-Mail in der ersten Zeile mit deiner HSR-Email (Schema vorname.nachname und nicht mit kürzel!)*

```bash
EMAIL='vorname.nachname@hsr.ch'
wget "https://raw.githubusercontent.com/raphiz/hsr-email-print/master/hsr-email-print"
sed -i -e 's/vorname.nachname@hsr.ch/'$EMAIL'/g' hsr-email-print
wget -O "Generic-PostScript_Printer-Postscript.ppd" "http://www.openprinting.org/ppd-o-matic.php?driver=Postscript&printer=Generic-PostScript_Printer&.submit=Generate+PPD+file&show=0&.cgifields=show&.cgifields=shortgui"
sudo mv Generic-PostScript_Printer-Postscript.ppd /etc/cups/ppd/
sudo mv hsr-email-print /usr/lib/cups/backend/hsr-email-print
sudo chmod 700 /usr/lib/cups/backend/hsr-email-print
sudo chown root:root /usr/lib/cups/backend/hsr-email-print
sudo lpadmin -p HSR -E -v hsr-email-print:/tmp -P /etc/cups/ppd/Generic-PostScript_Printer-Postscript.ppd
```

## Pakete erstellen
Um die Ubuntu und Fedora Pakete zu erstellen, folgende Kommandos ausführen:

```bash
sudo make package
```

Die Pakete finden sich anschliessend im Verzeichnis `dist/`
