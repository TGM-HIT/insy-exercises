---
hide:
  - navigation
---

# "_Parsing_" – Taskdescription

Teil der [Aufgabenreihe](../../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Implementiert `work/import_catalog.py`, ausführbar mit `python -X utf8 -m work.import_catalog`
und optional einem Eingabepfad als Argument. Ohne Argument gilt `data/catalog.xml`.
Prüft zuerst mit eurer DTD die Struktur und anschließend die Geschäftsregeln aus dem Vertrag.

Lest IDs, Name, Kategorie, Einheit, Preis, Bestand, Aktivstatus, optionale Beschreibung und
Tags in geeignete Python-Datentypen ein. Rechnet Preise mit `Decimal`, nicht mit binären Fließkommazahlen.
Erzeugt `out/import.json` als UTF-8-Objekt mit `currency`, `updated`, `products` und
`summary`. Das summary enthält `product_count`, `available_ids` und `active_stock_value`.
Preise und der Warenwert bleiben JSON-Zeichenketten mit zwei Nachkommastellen.

`available_ids` enthält aktive Produkte mit Bestand größer null, nach ID sortiert.
`active_stock_value` ist die Summe aus Preis mal Bestand aller aktiven Produkte.
Der Normalkatalog liefert **6**, **A100/A200/A210/A310** und **151.30**; der Leerkatalog
liefert **0**, eine leere Liste und **0.00**.

Ungültiges XML, eine Vertragsverletzung oder ein negativer Preis führen zu einem verständlichen
Fehler und einem Exitcode ungleich null. Erst nach vollständiger Prüfung wird die Ausgabe ersetzt.
Testet mindestens fehlenden Namen, doppelte ID, negativen Preis, Preis mit drei Nachkommastellen,
ungültigen Bestand und ungültigen Aktivstatus.

**Lernversuch:** Erzeugt zunächst eine gültige Ausgabe. Importiert dann eine Datei mit einem
gültigen ersten und fehlerhaften zweiten Artikel. Sagt voraus und prüft, ob die letzte gültige
Ausgabe erhalten bleibt. Dokumentiert eure Entscheidung gegen einen stillen Teilimport.

## Optionale Vertiefung (EK-Vorschlag)

Erzeugt mit `python -X utf8 tools.py generate out/large.xml --count 100000` einen großen,
wohlgeformten Testkatalog. Implementiert `work/stream_catalog.py` mit ereignisweisem `iterparse`.
Ermittelt Anzahl und Warenwert, ohne alle Produkte oder IDs zu sammeln. Entfernt verarbeitete
Produkte auch aus der Wurzel: `clear()` allein kann leere Elementobjekte im Baum zurücklassen.

Hier wird die bekannte, vom Generator erzeugte Struktur verarbeitet; eine vollständige
DTD-/Eindeutigkeitsprüfung des gesamten großen Imports ist nicht verlangt. Erwartung:
**100000 Artikel, 250000.00 EUR**. Vergleicht 10000 und 100000 Artikel mit einem Messwerkzeug,
z. B. `tracemalloc`; unterscheidet dessen Python-Allokationen vom gesamten Prozessspeicher.
Es gibt keine fest vorgeschriebene Laufzeit, die von eurer Hardware abhängt.

## Kontrollfragen

Was unterscheidet Parsing von Validierung? Warum ist `bool("false")` keine passende Umwandlung?
Wann hilft ereignisweises Verarbeiten, wann braucht ihr den vollständigen Baum?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
