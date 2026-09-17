---
hide:
  - navigation
---

# "_Datenformate im Vergleich_" – Taskdescription

Teil der [Aufgabenreihe](../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Vergleicht `data/catalog.xml`, `data/catalog.json` und die drei Dateien der CSV-Darstellung:
`products.csv`, `product-tags.csv`, `catalog-meta.json`. Alle beschreiben denselben Katalog.

1. Erstellt eine Tabelle zu Hierarchie, Datentypen, optionalen Feldern, Wiederholungen,
   Sonderzeichen und Bearbeitbarkeit. Belegt jede Aussage an einer konkreten Stelle.
2. Zeigt, wie A200 mit Ampersand und mehrzeiliger Beschreibung in allen Varianten erhalten
   bleibt. Erklärt die CSV-Behandlung des Kommas bei A100 und der Anführungszeichen bei A110.
3. Prüft Produktanzahl, IDs, aktive Artikel und die Tags von A100 nach dem Einlesen. Für die
   erste Prüfung dürft ihr Python `csv` und `json` sowie die gelieferten XML-Werkzeuge nutzen.
4. Empfehlt ein Format für den verschachtelten Lieferantenaustausch und eines für eine einfache
   Tabellenansicht. Nennt jeweils eine Grenze; vermeidet pauschale Aussagen wie „XML ist besser“.

**Lernversuch:** Sagt voraus, was `line.split(',')` bei A100 liefert. Vergleicht das Ergebnis
mit `csv.DictReader`. Zählt außerdem Datensätze mit dem CSV-Parser statt physische Textzeilen.

Erwartete Kontrollwerte: 6 Produkte, 5 aktive Produkte, 3 Kategorien; A100 besitzt die Tags
`regional` und `vegan`. CSV kann fehlend und leer hier nur durch eine zusätzliche Vereinbarung unterscheiden.

## Optionale Vertiefung

Skizziert einen verlustfreien Rundweg JSON → CSV-Dateien → JSON. Legt die Behandlung von
Boolean, Preis, Tags und fehlender Beschreibung ausdrücklich fest. Vergleicht fachliche Inhalte,
nicht Einrückung oder Schlüsselreihenfolge. Diese Vertiefung ist kein zusätzliches EK-Pflichtkriterium.

## Kontrollfragen

Warum ist eine CSV-Datei für sich genommen tabellarisch strukturiert? Welche Strukturinformationen
stehen bei JSON/XML in der Datei? Warum speichert der Vertrag Preise in JSON als Zeichenketten?
Ist ein fehlendes Feld immer dasselbe wie `null` oder ein leerer Text?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
