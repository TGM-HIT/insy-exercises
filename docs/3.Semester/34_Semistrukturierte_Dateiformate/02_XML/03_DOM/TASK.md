---
hide:
  - navigation
---

# "_DOM_" – Taskdescription

Teil der [Aufgabenreihe](../../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Implementiert `work/dom.py`. Startet das Skript vom Materialordner mit `python -X utf8 -m work.dom`.
Verwendet `from tools import load_dom`; das Ergebnis ist ein Dokument der Python-DOM-API.
Bearbeitet Knoten und Attribute, nicht die XML-Datei durch globale Text-Ersetzungen.

Ausgehend von `data/catalog.xml`:

1. Erhöht den Bestand von A100 von 12 auf 15.
2. Ändert das Attribut `active` von A300 auf `true`.
3. Fügt bei A210 genau einen Tag `regional` hinzu.
4. Speichert als UTF-8 nach `out/catalog-updated.xml`. Das Original bleibt unverändert.

Prüft durch erneutes Einlesen alle drei Änderungen und mindestens zwei unveränderte Produkte.
Die Ausgabe muss wieder gegen eure DTD gültig sein. Das Skript startet jedes Mal vom Original,
sodass wiederholtes Ausführen nicht unbemerkt weiterzählt oder Tags vervielfacht.

**Lernversuch:** Sagt voraus, ob `childNodes` eines eingerückten Elements nur Elementknoten
enthält. Prüft Knotentypen und erklärt die Rolle von Whitespace-Textknoten.
Testet eure Auswahl zusätzlich an einer kompakt formatierten Kopie ohne Einrückungen.

??? tip "Hilfe zum DOM"

    `documentElement`, `getElementsByTagName`, `getAttribute`, `setAttribute`,
    `createElement`, `createTextNode` und `appendChild` sind mögliche Werkzeuge.
    Sucht Produkte anhand der ID; feste Kindindizes hängen von Textknoten und Formatierung ab.

## Optionale Vertiefung (EK-Vorschlag)

Führt dieselben Änderungen auf `data/catalog-ns.xml` aus. Verwendet Namespace-URI und
lokalen Namen sowie `createElementNS` für neue Elemente. Prüft eine Variante, die einen
anderen Präfix für dieselbe URI benutzt. Der neue Tag muss im gleichen Namespace liegen.

## Kontrollfragen

Was ist der Unterschied zwischen Dokument, Element, Attribut und Textknoten? Warum verändert
das Setzen eines Attributs keinen Kindknoten? Was kostet das Laden eines vollständigen DOM im Speicher?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
