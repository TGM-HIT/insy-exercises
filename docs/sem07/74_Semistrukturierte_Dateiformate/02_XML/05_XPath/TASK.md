---
hide:
  - navigation
---

# "_XPath_" – Taskdescription

Teil der [Aufgabenreihe](../../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Tragt sechs eigene XPath-Ausdrücke in `work/queries.json` ein. Führt sie mit dem mitgelieferten
Saxon-Prozessor aus; die Ausdrücke liegen in einer Datei, damit Shell-Quoting nicht Teil der Aufgabe wird.

```bash
python -X utf8 tools.py xpath data/catalog.xml work/queries.json q1
```

| Schlüssel | Gesuchte Information | Kontrollwert für den Originalkatalog |
| --- | --- | --- |
| q1 | Anzahl aller Produkte | 6 |
| q2 | IDs verfügbarer Produkte in Dokumentreihenfolge | A100, A200, A210, A310 |
| q3 | Namen aller Produkte mit Tag vegan | Tomaten, sonnengereift; Zitrone "Bio"; Haferdrink |
| q4 | Alle unterschiedlichen Kategorien, sortiert | Gemüse, Getränke, Molkerei |
| q5 | Summe Preis × Bestand aktiver Produkte mit Dezimalarithmetik | 151.30 (numerisch; 151.3 ist derselbe Wert) |
| q6 | ID des preislich teuersten Produkts, bezogen auf die gespeicherte Preiseinheit | A200 |

Die Werkzeuge zeigen Ergebnisse als JSON-Liste ihrer Zeichenrepräsentationen an. Liefert für
ID-/Namenslisten Textwerte, nicht komplette serialisierte XML-Elemente. Bei q6 ist nur das
Maximum der gespeicherten Zahlen gefragt; wegen unterschiedlicher Einheiten ist das kein
fachlicher Vergleich des besten Einkaufspreises. Für Gleichstände sollen alle passenden IDs erscheinen.

Weist die Ergebnisse zusätzlich für `data/empty.xml` nach: Anzahl und Summe 0; übrige Listen leer.
Erklärt die Rolle von Kontextknoten, Pfaden, Attributen, Prädikaten und Funktionen an euren Ausdrücken.

**Lernversuch:** Übertragt eine funktionierende Abfrage unverändert auf `catalog-ns.xml`.
Sagt voraus, ob sie dieselben Elemente findet. Begründet das Ergebnis über vollständige XML-Namen.

??? tip "Hilfe zu XPath 3.1"

    Vergleicht `count`, `distinct-values`, `sort`, `sum`, `max`, `data` und `xs:decimal`.
    Der Ausdruck `for ... in ... return ...` erlaubt Berechnungen pro Artikel.
    Entscheidend ist die Semantik eures Ausdrucks, nicht die kürzeste Schreibweise.

## Optionale Vertiefung (EK-Vorschlag)

Speichert sechs entsprechende Namespace-Abfragen in `work/queries-ns.json`. Der Runner bindet
bereits `c` an `urn:tgm:insy:catalog:1`; Attribute wie `id` bleiben unpräfigiert.
Prüft auch einen anderen Präfix im XML-Dokument. Ergänzt eine XPath-3.1-Map Kategorie →
Produktanzahl (Getränke 3, Gemüse 2, Molkerei 1) und erklärt den Unterschied zur Liste von Knoten.

## Kontrollfragen

Warum ist `//product` bei einem Default-Namespace häufig leer? Worin unterscheiden sich
Knoten, atomare Werte und Sequenzen? Warum kann ein numerischer Vergleich eine Typumwandlung benötigen?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
