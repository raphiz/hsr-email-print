# Drucken via CUPS an der HSR

Dieses Skript ermöglicht bequemes Drucken von alternativen Betriebssystemen an der HSR.
Es wird ein neuer Drucker names HSR installiert, mit dem du drucken kannst. Im Hintergrund
wird dann eine E-Mail an den mobileprint service der HSR gesendet.

## Disclaimer
Dieses inoffizielle Skript ist auf eigene Gefahr zu verwenden!

## Installation

Führe folgende Kommandos schritt für schritt aus.
*Ersetze die E-Mail in der ersten Zeile mit deiner HSR-Email (Schema vorname.nachname und nicht mit kürzel!)*

```bash
EMAIL='vorname.nachname@hsr.ch'
wget "https://raw.githubusercontent.com/raphiz/hsr-email-print/master/pdf2email"
sed -i -e 's/vorname.nachname@hsr.ch/'$EMAIL'/g' pdf2email
wget -O "Generic-PostScript_Printer-Postscript.ppd" "http://www.openprinting.org/ppd-o-matic.php?driver=Postscript&printer=Generic-PostScript_Printer&.submit=Generate+PPD+file&show=0&.cgifields=show&.cgifields=shortgui"
sudo mv Generic-PostScript_Printer-Postscript.ppd /etc/cups/ppd/
sudo mv pdf2email /usr/lib/cups/backend/pdf2email
sudo chmod 700 /usr/lib/cups/backend/pdf2email
sudo chown root:root /usr/lib/cups/backend/pdf2email
sudo lpadmin -p HSR -E -v pdf2email:/tmp -P /etc/cups/ppd/Generic-PostScript_Printer-Postscript.ppd
```