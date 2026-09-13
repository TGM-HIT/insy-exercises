# Checkliste: ORM mit Django

## Grundlegend überwiegend

- [ ] Projekt lauffähig gemacht (venv oder Docker) und Pakete installiert.
- [ ] Datenmodelle (vorhandener User, Recipe, Ingredient, Contain) samt Beziehungen und begründeten Regeln umgesetzt.
- [ ] Eigene Modelle im Admin-Backend registriert und Adminbenutzer erstellt.
- [ ] Aussagekräftige Demorezepte über das Admin-Backend angelegt.
- [ ] Dokumentation

## Grundlegend vollständig

- [ ] Views für Index, `/recipe/<id>` und `/by-ingredient/<id>` mit korrekten ORM-Abfragen implementiert und geprüft.
- [ ] Endpoint `/new` zum Anlegen neuer Rezepte via POST mit JSON implementiert und geprüft.
- [ ] Endpoint `/remove/<id>` zum Löschen von Rezepten implementiert und geprüft.
- [ ] Demorezepte mittels `dumpdata` exportiert und Wiederherstellung nachgewiesen.
- [ ] Grundlegende Fragestellungen anhand der eigenen Lösung beantwortet.
- [ ] Abgabegespräch über Aufgaben und Fragestellungen einschließlich einer kleinen eigenen Änderung.
- [ ] Dokumentation

## Erweitert überwiegend

- [ ] Rezepttyp mittels begründeter Vererbung (Essen / Trinken) statt als gespeichertem Attribut umgesetzt.
- [ ] Zusätzliche Eigenschaften je Rezepttyp (Kohlensäure/Alkohol bzw. Kalorien) gespeichert; Schemaänderung und Übernahme der Demodaten erklärt.
- [ ] Dokumentation

## Erweitert vollständig

- [ ] Endpoints für Index, `/recipe/<id>` und `/by-ingredient/<id>` an die Vererbungsstruktur angepasst und mit beiden Typen geprüft.
- [ ] Ausführung sowohl über venv als auch über Docker gelöst und erklärt.
- [ ] Dokumentation
