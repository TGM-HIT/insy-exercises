---
hide:
  - navigation
---

# "_DTD und Validierung_" – Taskdescription

Teil der [Aufgabenreihe](../../TASK.md). Es gelten der gemeinsame
[Datenvertrag](../../DATA_CONTRACT.md), die Einrichtung und der **Bewertungsvorschlag** dort.
Arbeitsmaterial: [material.zip](../../material.zip). Die Lösungen erstellt ihr selbst.

## Auftrag

Entwickelt `work/catalog.dtd` selbst aus dem Datenvertrag. Verwendet zunächst ausschließlich
`data/catalog.xml` ohne Namespace. Die DTD soll Reihenfolge und Häufigkeit der Elemente,
Pflichtattribute, `active` als Enumeration und die Produkt-ID als XML-Typ `ID` beschreiben.
`currency` ist fest `EUR`; `updated` ist erforderlich. Ein leerer Katalog ist erlaubt.

```bash
python -X utf8 tools.py validate data/catalog.xml work/catalog.dtd
python -X utf8 tools.py validate data/empty.xml work/catalog.dtd
python -X utf8 tools.py validate cases/05-missing-name.xml work/catalog.dtd
```

Prüft zusätzlich `06-duplicate-id.xml` und `07-negative-price.xml`. Erwartung: normaler
und leerer Katalog gültig; fehlender Name und doppelte ID ungültig. Der negative Preis bleibt
bei einer passenden reinen DTD **gültig**, verletzt aber den Datenvertrag.

**Lernversuch:** Sagt voraus, ob eine DTD mit `price (#PCDATA)` den Wert `-3.20` oder den Text
`gratis` abweist. Führt beide Fälle aus und erklärt, welche zusätzliche Prüfung benötigt wird.
Testet außerdem eine selbst erzeugte Datei mit vertauschter Elementreihenfolge.

Die DTD wird als separate lokale Datei übergeben. Die XML-Dateien benötigen keinen DOCTYPE;
die sichere Parserkonfiguration bleibt erhalten. Lasst keine fremden externen Entities nachladen.

??? tip "Hilfe zur DTD"

    Prüft die Bedeutung von `?`, `*`, `+`, Sequenz, `#REQUIRED`, `#FIXED`, `ID` und Enumeration.
    Die Frage ist zuerst, welche Datensätze erlaubt sein sollen, danach, wie ihr die Regel schreibt.

## Optionale Vertiefung

Vergleicht anhand des Preisfelds, was XML Schema oder eine explizite Python-Regel zusätzlich
prüfen könnte. Eine komplette XSD ist nicht verlangt und kein zusätzliches EK-Pflichtkriterium.

## Kontrollfragen

Was bedeutet Validierung gegen ein bestimmtes Schema? Warum ist eine ID kein beliebiger
Freitext? Welche fachlichen Regeln bleiben nach erfolgreicher DTD-Validierung noch offen?

## Nachweis und Quellen

[Teilcheckliste](CHECK.md). Verwendet die thematisch passenden [geprüften Primärquellen](../../SOURCES.md).

*Version 20260913v1 – lokaler Entwurf.*
