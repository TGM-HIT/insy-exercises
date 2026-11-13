# Ersatzantwort bei Dienstausfall

`nbp-2026-11-13.xml` ist eine unverändert gespeicherte, echte XML-Antwort der
NBP-Kurstabelle A. Sie wurde mit dem mitgelieferten `abrufen.py` erfolgreich
abgerufen (HTTP 200). Verwenden Sie diese Datei nur als ausdrücklich
gekennzeichneten Ersatz, wenn der Live-Abruf nicht funktioniert.

- Herausgeber: Narodowy Bank Polski (NBP).
- Anfrage: https://api.nbp.pl/api/exchangerates/tables/a/?format=xml
- Kursdatum in der Antwort: **2026-11-13**.
- Tabellennummer: `221/A/NBP/2026`.
- Tatsächlicher Abrufzeitpunkt (UTC): `2026-11-13T11:27:55.116643+00:00`.
- SHA256: `bc3b79f668dbc43e1f81287249bdd24a7630dacf3889d7031e2f72d3c280203e`.
- Antwortgröße: 3009 Bytes.

Die Datei `nbp-2026-11-13-herkunft.json` enthält den vollständigen technischen
Abrufnachweis. Das Kursdatum ist der Zeitpunkt der veröffentlichten Kurse;
es ist unabhängig vom Zeitpunkt, zu dem eine Datei heruntergeladen wird.

Im Protokoll werden der gescheiterte Live-Abruf, die Nutzung dieser Ersatzdatei
und das Kursdatum festgehalten. Die XML-Antwort wird als Quellenbeleg abgegeben.
Die eigene XML-Datei und die DTD müssen weiterhin selbst erstellt werden.
