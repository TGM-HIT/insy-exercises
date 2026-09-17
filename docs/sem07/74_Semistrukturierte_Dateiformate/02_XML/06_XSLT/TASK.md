---
hide:
  - navigation
---

# "_XSLT_" – Taskdescription

Teil der [Aufgabenreihe](../../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Entwickelt `work/catalog.xsl` aus dem Gerüst zu einer Transformation mit XSLT 3.0.
Aus `data/catalog.xml` entsteht `out/catalog.html` für das Team des Bistros.

```bash
python -X utf8 tools.py xslt data/catalog.xml work/catalog.xsl out/catalog.html
```

Die HTML-Seite enthält Titel, Währung, Aktualisierungsdatum und eine Tabelle mit ID, Name,
Kategorie, Preis pro Einheit sowie Bestand. Zeigt nur aktive Produkte mit Bestand größer null.
Sortiert numerisch aufsteigend nach Preis, bei Gleichstand nach ID. Formatiert Preise mit
genau zwei Nachkommastellen und nennt EUR. Die Reihenfolge lautet **A210, A310, A100, A200**.
HTML erhält `lang="de"`, UTF-8, Tabellenüberschriften und verständliche Spaltenbezeichnungen.

Erstellt das Ergebnis durch Templates, Auswahl und Sortierung aus den XML-Daten. Eine fest
hineingeschriebene Produktliste ist keine Transformation. Verwendet reguläre Textausgabe,
damit Sonderzeichen escaped werden; `disable-output-escaping` wird nicht benötigt.

Öffnet das erzeugte HTML im Browser. Prüft Ampersand und Anführungszeichen sowie eine Testkopie
mit markupähnlichem Produktnamen. Die Namen müssen als Text erscheinen. Beim Leerkatalog
soll „Keine verfügbaren Produkte“ angezeigt werden, keine leere Tabelle ohne Erklärung.

**Lernversuch:** Vergleicht textuelle und numerische Preissortierung am gelieferten Katalog.
Sagt voraus, wo 12.50 bei textueller Sortierung landet, und erklärt die richtige Reihenfolge.

## Optionale Vertiefung (EK-Vorschlag)

Gruppiert verfügbare Produkte nach Kategorie. Innerhalb jeder Gruppe gilt die gleiche
Preissortierung; Gruppen sind alphabetisch sortiert. Ergänzt einen Parameter `min-stock`
(positive ganze Zahl, Standard 1) und berücksichtigt nur aktive Produkte mit mindestens diesem Bestand.
Für `--min-stock 10` bleiben **A100, A210, A310**, für 999 bleibt die Ausgabe leer.

Zeigt pro Gruppe und insgesamt den Warenwert der angezeigten Produkte mit Dezimalarithmetik.
Beim Standardwert ergeben sich Getränke **112.90**, Gemüse **38.40**, gesamt **151.30 EUR**;
bei Mindestbestand 10 gesamt **88.80 EUR**. Die ausschließlich inaktive Kategorie Molkerei
bekommt keinen leeren Abschnitt. Verwendet `xsl:for-each-group` und begründet die Gruppierung.

## Kontrollfragen

Was unterscheidet XSLT von CSS? Was macht ein Template-Match? Warum ist fertiges HTML im
Browser eine andere Sache als native XSLT-Verarbeitung? Wann sind Parameter besser als
mehrere fast identische Stylesheets?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
