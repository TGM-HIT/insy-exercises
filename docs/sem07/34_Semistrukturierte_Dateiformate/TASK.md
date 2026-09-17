---
hide:
  - navigation
---

# "_Semistrukturierte Dateiformate_" – Aufgabenreihe

## Ausgangslage und Ziele

Das Bistro **Küche & Bar** erhält den Artikelkatalog eines Lieferanten in unterschiedlichen
Formaten. Die Einkaufsliste benötigt verlässliche Preise und Bestände, das Team eine lesbare
HTML-Übersicht. Ihr entwickelt einen kleinen lokalen Verarbeitungsablauf: Daten verstehen,
prüfen, ändern, auswerten und für Menschen darstellen.

Dabei trennt ihr drei Fragen: Ist die Datei syntaktisch lesbar? Entspricht ihre Struktur dem
vereinbarten Vertrag? Sind ihre Inhalte fachlich sinnvoll? Ein erfolgreicher Parser beantwortet
nur die erste Frage. Der selbst entwickelte Katalog ist ein Unterrichtsformat, kein vorgegebener
Branchenstandard und keine vollständige Warenwirtschaft.

**Status:** Neuer Entwurf vom 13.09.2026. Das bisherige Repository enthielt nur ein leeres
Themenraster. Es gab keine GK-/EK-Zuordnung, die übernommen werden konnte. Die untenstehende
Bewertung ist deshalb ausdrücklich ein **Vorschlag**, den die Lehrkraft vor dem Einsatz festlegt.

## Einrichtung

Voraussetzungen: Python-Grundkenntnisse, Dateien und Kommandozeile; grundlegendes HTML genügt
für die letzte Station. Verwendet keine vorhandene Datenbank aus den vorherigen Aufgaben.

Ladet [material.zip](material.zip) herunter und entpackt es. Arbeitet im enthaltenen Ordner
`material`, in dem `tools.py` liegt. Einrichtung unter Windows/PowerShell:

```powershell
py -3.14 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -X utf8 tools.py versions
.\.venv\Scripts\python.exe -X utf8 tools.py parse data/catalog.xml
```

Linux/macOS: `python3.14 -m venv .venv`, danach `.venv/bin/python` verwenden. Als gleichwertige
Alternative dienen die mitgelieferten Docker-Dateien:

```bash
docker compose build
docker compose run --rm tools python tools.py versions
docker compose run --rm tools python tools.py parse data/catalog.xml
```

Alle weiteren Befehle verwenden `python` als Kurzform für euren venv-Interpreter.
Im Container setzt ihr `docker compose run --rm tools` davor. Es genügt **ein** Ausführungsweg.
Die vollständigen Hinweise einschließlich Windows-Pfaden stehen in der Paket-README.

| Technik | Verwendeter Stand | Zweck |
| --- | --- | --- |
| Python | 3.14.7 | Gleiche stabile Hauptlinie wie im ORM-Modul. |
| XML | 1.0, 5. Ausgabe | Bewusst breit interoperables Austauschformat; die ältere Publikation ist kein Grund für XML 1.1. |
| DTD | Bestandteil von XML 1.0 | Struktur, Reihenfolge und IDs; Grenzen bei Datentypen erkennen. |
| DOM | Python `xml.dom.minidom`, über defusedxml 0.7.1 | Knoten, Attribute und Änderungen an einem echten DOM. |
| lxml | 6.1.3 | Lokales Parsing und explizite DTD-Validierung. |
| XPath / XSLT | 3.1 / 3.0 mit SaxonC-HE 13.0.0 | Aktuelle standardisierte Abfragen und Transformationen ohne kostenpflichtige Lizenz. |
| CSV / JSON | Vereinbarter CSV-Dialekt nach RFC 4180 / JSON nach RFC 8259 | Datenmodell und Datentypen vergleichen. |

Versionen und [Quellen](SOURCES.md) wurden am **13.09.2026** geprüft. XPath-/XSLT-4.0-Entwürfe
werden nicht benötigt. lxml unterstützt selbst XPath 1.0/XSLT 1.0; verwendet deshalb für die
beiden letzten Stationen ausdrücklich die Saxon-Werkzeuge im Paket.

Browser sind hier nur für **fertiges HTML** zuständig. Native XSLT-Verarbeitung wird aus
Browsern entfernt; die Aufgabe funktioniert durch lokale Transformation unabhängig davon.

## Arbeitsweise

Die Dateien in `data/` bleiben als gemeinsame Ausgangsbasis unverändert. Jede Station startet
mit diesen Originalen; Ergebnisse legt ihr unter `out/` ab. So blockiert ein Fehler in einer
frühen Station nicht die späteren Aufgaben. Verwendet UTF-8 explizit; beim Arbeiten mit Preisen
Dezimalarithmetik. Die [vereinbarte Struktur und Geschäftsregeln](DATA_CONTRACT.md) gelten für alle Stationen.

Vorgegeben sind Daten, harmlose Fehlerfälle, ein CLI-Werkzeug und leere Arbeitsdateien.
Ihr entwickelt Formatentscheidung, Reparaturen, DTD, DOM-Änderung, Importlogik, XPath-Ausdrücke
und XSLT selbst. Die Vorlagen enthalten keine vollständigen Lösungen. Hilfekästen sind erlaubt;
ihre Nutzung verursacht keinen Bewertungsabzug.

Die Parser-Werkzeuge lehnen DOCTYPE und benutzerdefinierte Entities ab. DTD-Validierung erfolgt
gezielt mit eurer separaten lokalen DTD. Verwendet nur die gelieferten oder selbst erstellte
DTD-Dateien, Abfragen und Stylesheets. Eigene Sicherheitsangriffe oder fremde Server sind
nicht Teil der Aufgabe.

## Stationen

| Reihenfolge | Teilaufgabe | Ergebnis |
| --- | --- | --- |
| 1 | [Datenformate im Vergleich](01_Datenformate_im_Vergleich/TASK.md) | Begründete Formatwahl und verlustfreier Datenvergleich innerhalb des Vertrags. |
| 2 | [Aufbau und Wohlgeformtheit](02_XML/01_Aufbau_und_Wohlgeformtheit/TASK.md) | Reparierte XML-Dateien und erklärte Parsermeldungen. |
| 3 | [DTD und Validierung](02_XML/02_DTD_und_Validierung/TASK.md) | Eigene DTD, Positiv-/Negativtests und Grenzen der Validierung. |
| 4 | [DOM](02_XML/03_DOM/TASK.md) | Gezielte Änderung ohne Verlust anderer Inhalte. |
| 5 | [Parsing](02_XML/04_Parsing/TASK.md) | Geprüfter Import mit JSON-Ausgabe und nachvollziehbaren Fehlern. |
| 6 | [XPath](02_XML/05_XPath/TASK.md) | Sechs eigene Abfragen mit Sollwerten. |
| 7 | [XSLT](02_XML/06_XSLT/TASK.md) | Aus XML erzeugte, nutzbare HTML-Preisliste. |

Plant nach jeder Station einen kleinen Zwischencheck ein. Führt vor den markierten
Lernversuchen eine kurze Vorhersage durch und erklärt anschließend die Beobachtung.

## Abgabe

Einzelarbeit. Abzugeben sind eure Dateien aus `work/`, relevante Ausgaben aus `out/` und ein
kurzes Protokoll mit Formatentscheidung, Testtabelle und Antworten auf die Fragen der Stationen.
Jeder Test nennt Eingabe, Aktion, Soll, Ist und Begründung. Keine `.venv`, Cache-Dateien oder
riesigen generierten Testdateien abgeben; für große Daten genügen Erzeugungsbefehl und Ergebnis.

Die Lösung muss aus dem Materialpaket und euren Arbeitsdateien erneut ausführbar sein.
Kennzeichnet Quellen und KI-Unterstützung. Im Gespräch erklärt ihr eine Abfrage und eine
kleine eigene Änderung, beispielsweise einen anderen Bestandsschwellwert oder eine neue
optionale Beschreibung. Fachliche Nachweise zählen; aufwendiges Grafikdesign ist nicht verlangt.

## Bewertungsvorschlag

Dieser Gesamtvorschlag ist noch keine verbindliche Kursbewertung. Die Teilchecklisten dienen
als Nachweise und ergeben keine sieben zusätzlich zu addierenden Noten. Die Grundaufgaben
aller Stationen gehören zum Grundbereich. Vertiefungen sind optional.

### Grundlegend überwiegend

- [ ] Formatvergleich, Wohlgeformtheit und DTD mit eigenen Erklärungen und aussagekräftigen Tests bearbeitet.
- [ ] DOM-Änderung an den geforderten Produkten erfolgreich, übrige Daten erhalten.
- [ ] Grundlegendes Einlesen, mindestens drei korrekte XPath-Abfragen und eine aus XML erzeugte HTML-Tabelle lauffähig.

### Grundlegend vollständig

- [ ] Alle Grundaufgaben der sieben Stationen vollständig; Import prüft Geschäftsregeln, Fehler verändern die letzte gültige Ausgabe nicht.
- [ ] Alle sechs XPath-Abfragen und die gefilterte, sortierte HTML-Ausgabe mit Sollwerten nachgewiesen.
- [ ] Ergebnisse reproduzierbar; Lernversuche, Fragestellungen und Abgabegespräch nachvollziehbar.

### Erweitert überwiegend

- [ ] Namespace-Varianten bei DOM und XPath korrekt bearbeitet und erklärt.
- [ ] Großer XML-Katalog ereignisweise verarbeitet; Ergebnis und Speicherverhalten nachvollziehbar geprüft.

### Erweitert vollständig

- [ ] XSLT-Ausgabe nach Kategorien gruppiert, mit Parameter und korrektem Dezimal-Warenwert; leere Gruppen und leere Ergebnisse sinnvoll behandelt.
- [ ] Eine XPath-3.1-Map mit Kategorienanzahlen umgesetzt und die eingesetzten erweiterten Konzepte im Gespräch erklärt.

Weitere Vertiefungen in den Stationen sind zusätzliche Lernangebote, keine versteckten
Pflichtkriterien. Vor Unterrichtseinsatz sind Umfang und Gewichtung mit der Lehrkraft festzulegen.

*Mit KI-Unterstützung erstellt. Version 20260913v1 – lokaler Unterrichtsentwurf.*
