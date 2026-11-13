# Didaktisches Modell: guter Schüler

## Aussagegrenze

Dieses Profil ist eine modellierte Bearbeitung, kein Experiment mit einem Schüler und keine Prognose einer offiziellen Note. Das Profil nimmt sichere XML-Grundlagen, sorgfältiges Übertragen von Regeln und eine systematische Trennung von Syntax, Struktur und fachlichen Werten an. Unterrichtszeiten, Entscheidungen und Verhalten sind didaktische Annahmen. Tatsächlich ausgeführt wurden die genannten Dateiarbeiten, Quellenkopie, Rechenoperationen und CLI-Werkzeugprüfungen sowie der separat durch die koordinierende QA durchgeführte Browsernachweis. Ein Liveausfall wird nicht behauptet.

Gelesen wurden ausschließlich die neue Aufgabenfassung mit sieben Fragen, README, Datenvertrag, DTD-Hilfe, Dokumentationsvorlage und die vorgegebene NBP-Ersatzantwort. Zusätzlich wurden die fertigen CLI-Oberflächen `--help` und `versionen` benutzt. Referenzlösungen, frühere Lösungsberichte und fremde Simulationen wurden nicht gelesen. Eine Lehrerhilfe wird im Modell nicht angenommen.

## Modellierter Verlauf und Zeitbudget

Das verfügbare Budget beträgt 200 Unterrichtsminuten. Die folgende mittlere Planung von 175 Minuten ist eine Schätzung; besonders Einrichtung und DTD-Eingabe können länger dauern. Die 25 Minuten Reserve erlauben gewöhnliche Tippfehler und erneute Prüfungen, sind aber kein Nachweis, dass jeder Schüler das Budget einhält. Der hier bereitgestellte Interpreter war bereits eingerichtet; eine eigene Installation wurde nicht ausgeführt.

| UE | Modellierte Tätigkeit und Entscheidung | Geschätzte Minuten | Reserve innerhalb der UE |
| --- | --- | ---: | ---: |
| 1 | Einrichtung lesen und Befehle zuordnen (10); Aufgabe und Datenvertrag lesen (12); Ersatzantwort kopieren und EUR/CZK/Datum finden (12); Kursrichtung und Quellenangabe festhalten (8). | 42 | 8 |
| 2 | XML mit drei Kursen und Hinweis schreiben (18); mit Originalantwort vergleichen und XML prüfen (10); Fragen 1–3 beantworten (6); Dokumentation ergänzen (6). | 40 | 10 |
| 3 | DTD-Hilfe auf das eigene Format übertragen (22); DTD-Regeln und Validierung kontrollieren (12); Fragen 4–5 beantworten (5); Testzeile vorbereiten (4). | 43 | 7 |
| 4 | Fehlerkopien erstellen und prüfen (12); Fragen 6–7 beantworten (7); beide Rechnungen und Empfehlung (10); Browserimport und Screenshot (10); Dokumentation/Abgabekontrolle (11). | 50 | 0 |
| **Gesamt** | **Fragenzeit: 18 Minuten, bereits enthalten.** | **175** | **25** |

Die 10 Minuten für Browserimport und Screenshot sind ebenso wie alle anderen Unterrichtszeiten lediglich geschätzt. Der inzwischen tatsächlich vorliegende Browsernachweis macht diese Schätzung nicht zu einer gemessenen Schülerbearbeitungsdauer. Die gesamte Modellplanung bleibt bei 175 Minuten mit 25 Minuten Reserve; es wurden keine 200 Echtminuten gewartet.

## Entscheidungen und Hilfen

- Die Ersatzantwort wurde für einen kontrollierbaren Vergleich vorgegeben, nicht wegen eines beobachteten Dienstausfalls. Ihre unveränderte Kopie wurde durch gleiche SHA-256-Prüfsummen bestätigt (`nachweise/quellenkopie.json`).
- Zuerst wurden `Code` und `Mid` einander zugeordnet. `4.4070` bedeutet PLN je EUR, daher wird zum EUR-Vergleich durch diesen Wert geteilt. Für CZK wird vorher mit `0.1806` multipliziert.
- Die DTD-Hilfe liefert die Schreibweise; der Datenvertrag liefert die konkreten Regeln. Daraus wurden `(quelle, kurs+, hinweis?)`, Pflichtattribute und Enumerationen selbst zusammengesetzt. Der Hinweis zur Ersatzdatenbasis wird tatsächlich verwendet.
- Die Kopien wurden aus dem vollständigen Format abgeleitet: einmal ein falsches Endtag, einmal die vollständig entfernte Quelle. Das korrekte Original blieb unverändert.
- Es wurde kein zusätzlicher zufälliger Fehler eingebaut, um ein bestimmtes Profilbild zu erzeugen. Der erste tatsächlich geprüfte Entwurf bestand die Originalprüfungen. Daraus folgt keine Garantie fehlerfreier Schülerarbeit; die zwei absichtlichen Fehlerkopien sind die vom Auftrag verlangten Tests.
- Die fachlichen Grenzen von `#PCDATA` und `CDATA` wurden aus Datenvertrag und Hilfe abgeleitet. Für die sieben Antworten war im angenommenen Profil keine Lehrerhilfe erforderlich.

## Tatsächlich ausgeführte Nachweise

Interpreter: `SOURCE_WORKSPACE/xml-webservice-20261113/qa/tools-venv/Scripts/python.exe`\
Prüfskript: `SOURCE_WORKSPACE/xml-webservice-20261113/material/pruefen.py`\
Gemeldete Versionen: Python 3.14.7, lxml 6.1.3, libxml2 2.11.9.

Alle Dateiargumente wurden als absolute Pfade übergeben. Vollständige Befehle, Ausgaben und Exitcodes sind in `nachweise/cli-pruefungen.json` gespeichert.

| Tatsächlicher Aufruf | Beobachtetes Ergebnis |
| --- | --- |
| Original, Modus `xml` | `WOHLGEFORMT`, Exit 0 |
| Original, Modus `dtd` | `DTD-GÜLTIG`, Exit 0 |
| Syntaxkopie, Modus `xml` | `XML-FEHLER`, Exit 1; falsches Endtag in Zeile 4 |
| Strukturkopie, Modus `xml` | `WOHLGEFORMT`, Exit 0 |
| Strukturkopie, Modus `dtd` | `DTD-UNGÜLTIG`, Exit 1; erforderliche Quelle fehlt |

Rechencheck: AT 192,00 EUR; PL 192,87 EUR; CZ 170,07 EUR. Daraus folgt die Empfehlung CZ und 21,93 EUR Ersparnis gegenüber AT.

**Nachtrag zum tatsächlichen Browsernachweis:** Die koordinierende QA importierte den tatsächlichen Inhalt der finalen Datei `arbeit/wechselkurse.xml` über das vorhandene XML-Textfeld. Der Dateidialog hatte zuvor einen Timeout erreicht; ein erfolgreicher Dateidialogimport wird nicht behauptet. Der Rechner bestätigte die Format- und Werteprüfung und zeigte AT 192,00 EUR, PL 192,87 EUR, CZ 170,07 EUR und 21,93 EUR Ersparnis für CZ gegenüber AT. Die Vergleichsansicht ist als `vergleich.png` gesichert; das gemeinsame Browserprotokoll liegt unter `../browser-results.json`. Der Browser prüfte keine DTD; dafür gilt weiterhin der tatsächliche CLI-Nachweis.

## Einordnung nach den GK-Kriterien der Aufgabe

Die vorliegenden XML-/DTD-Dateien erfüllen die geforderten Regeln einschließlich der optionalen Anmerkung und der Enumerationen. Beide Fehlerfälle ergeben die erwarteten unterschiedlichen Prüfresultate. Alle sieben Antworten unterscheiden Syntax, Struktur und fachliche Werteprüfung nachvollziehbar. Rechencheck, Vergleich und Empfehlung stimmen mit den übernommenen Kursen überein; die Quellen- und KI-Angaben sind transparent.

Für dieses Modell sind nach dem ergänzten Browsernachweis die Kriterien der Stufe **„Grundanforderungen zur Gänze erfüllt“** belegt: Die eigene XML-Datei wurde erfolgreich in der Anwendung verwendet, die angezeigten Kosten stimmen und die Vergleichsansicht ist gesichert. Die verwendete Datenbasis ersetzt den eigenen Liveabruf in dieser ausdrücklich vorgegebenen Offline-Simulation; daraus wird keine praktisch beobachtete Abrufkompetenz abgeleitet. Die Aussage betrifft das didaktische Modell mit bereitgestellter Ersatzantwort, keine empirisch beobachtete Schülerleistung. Es wird keine offizielle Note vergeben und keine prozentuale Erfolgswahrscheinlichkeit geschätzt.
