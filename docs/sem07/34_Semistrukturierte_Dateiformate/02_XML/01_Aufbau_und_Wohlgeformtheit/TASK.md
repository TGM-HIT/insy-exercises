---
hide:
  - navigation
---

# "_Aufbau und Wohlgeformtheit_" – Taskdescription

Teil der [Aufgabenreihe](../../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Untersucht `data/catalog.xml`: Prolog, Wurzelelement, Attribute, Kindknoten, Text und leere
Elemente. Zeichnet einen kleinen Baum für A100 einschließlich eines Attribut- und Textknotens.

Repariert `cases/01-unescaped.xml` bis `04-two-roots.xml` in getrennten Kopien unter `out/`.
Notiert zuerst den vermuteten Fehler, dann die Parsermeldung und eure kleinste sinnvolle Änderung.
Bei zwei Wurzeln könnt ihr einen gemeinsamen Container wählen; diese Reparaturen müssen
wohlgeformt sein, aber noch nicht dem Katalogvertrag entsprechen.

```bash
python -X utf8 tools.py parse cases/01-unescaped.xml
python -X utf8 tools.py parse out/01-fixed.xml
```

**Lernversuch:** Stellt denselben Text mit Ampersand einmal als Zeichenreferenz und einmal
in CDATA dar. Sagt voraus, welchen Textwert der Parser liefert, und prüft ihn.
Entfernt anschließend bei einer Katalogkopie den Namen eines Produkts: Ist die Datei weiterhin wohlgeformt?

Der gelieferte DOCTYPE-Test `cases/08-doctype.xml` ist syntaktisch wohlgeformt. Unser Werkzeug
weist ihn trotzdem absichtlich zurück. Unterscheidet diese Anwendungsregel von XML-Syntaxfehlern.

## Optionale Vertiefung

Vergleicht `catalog.xml` und `catalog-ns.xml`: Was ändert der Default-Namespace an den Namen
der Elemente? Prüft, ob unpräfigierte Attribute ebenfalls in diesem Namespace liegen.
Das bereitet die Namespace-Vertiefungen bei DOM und XPath vor.

## Kontrollfragen

Warum bedeuten „wohlgeformt“, „DTD-gültig“ und „fachlich korrekt“ etwas Verschiedenes?
Warum sind XML-Namen groß-/kleinschreibungsabhängig? Welche Zeichenfolge kann nicht direkt in CDATA stehen?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
